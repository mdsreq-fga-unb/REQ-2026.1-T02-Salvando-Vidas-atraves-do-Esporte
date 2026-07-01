import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

import '../../mocks/supabase_client.mocks.dart';
import '../../mocks/supabase_fakes.dart';

// 1. O DUBLE DE AUTENTICAÇÃO
class FakeAuth extends Fake implements GoTrueClient {
  User? _currentUser;
  bool simularErro = false;

  void setLogado(bool logado) {
    _currentUser = logado
        ? User(
            id: 'user-123',
            appMetadata: {},
            userMetadata: {},
            aud: 'auth',
            createdAt: '',
          )
        : null;
  }

  @override
  User? get currentUser => _currentUser;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #signInWithPassword) {
      if (simularErro) throw Exception('Credenciais inválidas');
      final user = User(
        id: 'user-123',
        appMetadata: {},
        userMetadata: {},
        aud: 'auth',
        createdAt: '',
      );
      return Future.value(AuthResponse(user: user));
    }
    if (invocation.memberName == #signOut) {
      _currentUser = null;
      return Future.value();
    }
    return super.noSuchMethod(invocation);
  }
}

void main() {
  late UserService userService;
  late MockSupabaseClient mockSupabaseClient;
  late FakeAuth fakeAuth;
  late ProviderContainer container;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    fakeAuth = FakeAuth();

    when(mockSupabaseClient.auth).thenReturn(fakeAuth);

    container = ProviderContainer(
      overrides: [
        supabaseClientProvider.overrideWithValue(mockSupabaseClient),
      ],
    );
    userService = container.read(userServiceProvider);
  });

  // O JSON limpo do Usuário (Respeitando a regra do CPF/Telefone sem máscara!)
  final localUserSimuladoJson = {
    'id': 'user-123',
    'role': 'admin',
    'nome': 'João Silva',
    'telefone': '61999999999',
    'cpf': '12345678900',
    'email': 'teste@teste.com',
    'funcao': 'Teste',
    'faixa': 'branca',
  };

  group('UserService -', () {
    test(
      'deve realizar login com sucesso e carregar o usuario local',
      () async {
        // 1. ARRANGE
        fakeAuth.simularErro = false;
        when(
          mockSupabaseClient.from('users'),
        ).thenAnswer((_) => FakeQueryBuilder([localUserSimuladoJson]));

        // 2. ACT
        final resultado = await userService.login('teste@teste.com', 'senha');

        // 3. ASSERT
        expect(resultado, isTrue);
        expect(userService.localUser, isNotNull);
        expect(userService.localUser!.nome, 'João Silva');
        expect(userService.isAdmin, isTrue);
      },
    );

    test(
      'deve lancar erro ao tentar fazer login com credenciais invalidas',
      () async {
        // 1. ARRANGE
        fakeAuth.simularErro = true;

        // 2. ACT & ASSERT
        expect(
          () async =>
              await userService.login('teste@teste.com', 'senha-errada'),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('deve identificar usuario ja logado no sistema', () async {
      // 1. ARRANGE
      fakeAuth.setLogado(true);
      when(
        mockSupabaseClient.from('users'),
      ).thenAnswer((_) => FakeQueryBuilder([localUserSimuladoJson]));

      // 2. ACT
      final resultado = await userService.isLoggedIn();

      // 3. ASSERT
      expect(resultado, isTrue);
      expect(userService.localUser!.cpf, '12345678900');
    });

    test('deve retornar falso ao verificar usuario nao logado', () async {
      // 1. ARRANGE
      fakeAuth.setLogado(false);

      // 2. ACT
      final resultado = await userService.isLoggedIn();

      // 3. ASSERT
      expect(resultado, isFalse);
    });

    test('deve realizar logout e limpar o usuario local', () async {
      // 1. ARRANGE
      fakeAuth.setLogado(true);
      userService.localUser = LocalUser.fromMap(localUserSimuladoJson);

      // 2. ACT
      await userService.logout();

      // 3. ASSERT
      expect(fakeAuth.currentUser, isNull);
      expect(userService.localUser, isNull);
    });

    test('deve listar usuarios com sucesso', () async {
      // 1. ARRANGE
      when(
        mockSupabaseClient.from('users'),
      ).thenAnswer((_) => FakeQueryBuilder([localUserSimuladoJson]));

      // 2. ACT
      final usuarios = await userService.listUsers();

      // 3. ASSERT
      expect(usuarios, isA<List<LocalUser>>());
      expect(usuarios.length, 1);
      expect(usuarios.first.email, 'teste@teste.com');
    });

    test('deve registrar usuario com sucesso via rpc', () async {
      // 1. ARRANGE
      when(
        mockSupabaseClient.rpc(any, params: anyNamed('params')),
      ).thenAnswer((_) => FakeFilterBuilder<dynamic>([]));

      final novoUsuario = LocalUser.fromMap(localUserSimuladoJson);

      // 2. ACT & ASSERT
      expect(
        () async => await userService.registerUser(novoUsuario),
        returnsNormally,
      );
    });

    test('deve atualizar usuario com sucesso via rpc', () async {
      // 1. ARRANGE
      when(
        mockSupabaseClient.rpc(any, params: anyNamed('params')),
      ).thenAnswer((_) => FakeFilterBuilder<dynamic>([]));

      // 2. ACT & ASSERT
      expect(
        () async => await userService.updateUser({
          'id': 'user-123',
          'nome': 'Nome Novo',
        }),
        returnsNormally,
      );
    });

    test('deve deletar usuario com sucesso via rpc', () async {
      // 1. ARRANGE
      when(
        mockSupabaseClient.rpc(any, params: anyNamed('params')),
      ).thenAnswer((_) => FakeFilterBuilder<dynamic>([]));

      // 2. ACT & ASSERT
      expect(
        () async => await userService.deleteUser('user-123'),
        returnsNormally,
      );
    });
  });
}
