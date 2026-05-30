import 'package:salvando_vidas/data/supabase_call.dart';

import '../test_imports.dart';

import 'package:salvando_vidas/data/services/user_service.dart';
import 'package:salvando_vidas/domain/local_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late MockSupabaseClient supabase;
  late MockGoTrueClient mockAuth;
  late UserService userService;

  // provideDummy<Result<bool>>(Success(false));

  setUp(() {
    supabase = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    userService = UserService(supabase);

    when(supabase.auth).thenReturn(mockAuth);
  });

  test("UserService - Faz login e logout com sucesso", () async {
    // Arrange
    final res = AuthResponse(
      user: User(
        id: "111",
        appMetadata: {},
        userMetadata: {},
        aud: "111",
        createdAt: "2026-01-01",
      ),
    );

    when(
      mockAuth.signInWithPassword(
        email: "teste@teste.com",
        password: "SenhaTeste",
      ),
    ).thenAnswer((_) async => res);

    when(mockAuth.signOut()).thenAnswer((_) async {});

    when(supabase.from('users')).thenAnswer(
      (_) => FakeQueryBuilder([
        {"nome": "João Silva", "role": "admin"},
      ]),
    );

    // Act
    final result = await userService.login("teste@teste.com", "SenhaTeste");

    if (result case Success(value: final v)) {
      expect(v, isTrue);
      expect(userService.localUser?.name, "João Silva");
      expect(userService.localUser?.role, Role.admin);

      await userService.logout();
      expect(userService.localUser, isNull);
    } else {
      fail("Esperava que o usuário fizesse login com sucesso");
    }
  });

  test(
    "UserService - Login falha ao autenticar com um usuário inexistente",
    () async {
      // Arrange
      when(
        mockAuth.signInWithPassword(
          email: "teste@teste.com",
          password: "SenhaTeste",
        ),
      ).thenThrow(AuthApiException("Usuário não cadastrado"));

      // Act
      final result = await userService.login("teste@teste.com", "SenhaTeste");

      // Assert
      if (result case Failure(message: final m)) {
        expect(m, isA<String>());
      } else {
        fail("Esperava que login falhasse");
      }
    },
  );

  test("UserService - Sessão anterior é identificada", () async {
    // Arrange
    when(mockAuth.currentUser).thenReturn(
      User(
        id: "111",
        appMetadata: {},
        userMetadata: {},
        aud: "111",
        createdAt: "2026-01-01",
      ),
    );

    when(supabase.from('users')).thenAnswer(
      (_) => FakeQueryBuilder([
        {"nome": "João Silva", "role": "admin"},
      ]),
    );

    // Act
    final result = await userService.isLoggedIn();

    // Assert
    expect((result as Success<bool>).value, isTrue);
    expect(userService.localUser?.name, "João Silva");
    expect(userService.localUser?.role, Role.admin);
  });

  test("UserService - Sessão anterior inválida é identificada", () async {
    // Arrange
    when(mockAuth.currentUser).thenReturn(null);

    // Act
    final result = await userService.isLoggedIn();

    // Assert
    expect((result as Success<bool>).value, isFalse);
  });
}
