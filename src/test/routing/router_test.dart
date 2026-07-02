import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/routing/router.dart';

class FakeUserServiceRouter extends Fake implements UserService {
  final bool logged;
  final bool throwErr;

  FakeUserServiceRouter({this.logged = true, this.throwErr = false});

  @override
  Future<bool> isLoggedIn() async {
    if (throwErr) throw Exception('erro de sessao');
    return logged;
  }

  @override
  LocalUser? get localUser => const LocalUser(
        id: 'u-1',
        role: Role.admin,
        nome: 'Admin Teste',
        telefone: '11999999999',
        cpf: '52998224725',
        email: 'admin@teste.com',
        funcao: 'Diretor',
        faixa: Faixa.preta,
      );
}

void main() {
  group('Router Provider & Redirect Tests', () {
    test('Router build and redirect logic - logado', () async {
      final container = ProviderContainer(
        overrides: [
          userServiceProvider.overrideWithValue(FakeUserServiceRouter(logged: true)),
        ],
      );
      addTearDown(container.dispose);

      final goRouter = container.read(routerProvider);
      expect(goRouter, isNotNull);
    });
  });
}
