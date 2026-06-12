import '../test_imports.dart';

// void main() {
//   late MockSupabaseClient supabase;
//   late MockGoTrueClient mockAuth;
//   late UserService userService;
//   late Logger logger;

//   // provideDummy<Result<bool>>(Success(false));

//   setUp(() {
//     supabase = MockSupabaseClient();
//     mockAuth = MockGoTrueClient();
//     userService = UserService(supabase);
//     logger = Logger();

//     when(supabase.auth).thenReturn(mockAuth);
//   });

//   test("UserService - Faz login e logout com sucesso", () async {
//     // Arrange
//     final res = AuthResponse(
//       user: User(
//         id: "111",
//         appMetadata: {},
//         userMetadata: {},
//         aud: "111",
//         createdAt: "2026-01-01",
//       ),
//     );

//     when(
//       mockAuth.signInWithPassword(
//         email: "teste@teste.com",
//         password: "SenhaTeste",
//       ),
//     ).thenAnswer((_) async => res);

//     when(mockAuth.signOut()).thenAnswer((_) async {});

//     when(supabase.from('users')).thenAnswer(
//       (_) => FakeQueryBuilder([
//         {
//           "id": "111",
//           "role": "admin",
//           "nome": "João Silva",
//           "telefone": "61999999999",
//           "cpf": "99999999999",
//           "email": "teste@teste.com",
//         },
//       ]),
//     );

//     // Act
//     final result = await userService.login("teste@teste.com", "SenhaTeste");
//     final user = userService.localUser;

//     // Assert
//     switch (result) {
//       case Success(:final value):
//         expect(value, isTrue);
//       case Failure(:final error):
//         logger.e("Erro detectado", error: error);
//         fail("Esperava que o usuário fizesse login com sucesso");
//     }

//     switch (user) {
//       case null:
//         fail("Usuário não deve ser nulo");
//       case LocalUser(:final nome, :final role):
//         expect(nome, "João Silva");
//         expect(role, Role.admin);
//     }

//     await userService.logout();
//     expect(userService.localUser, isNull);
//   });

//   test(
//     "UserService - Login falha ao autenticar com um usuário inexistente",
//     () async {
//       // Arrange
//       when(
//         mockAuth.signInWithPassword(
//           email: "teste@teste.com",
//           password: "SenhaTeste",
//         ),
//       ).thenThrow(AuthApiException("Usuário não cadastrado"));

//       // Act
//       final result = await userService.login("teste@teste.com", "SenhaTeste");

//       // Assert
//       switch (result) {
//         case Failure(:final message):
//           expect(message, isA<String>());
//         case Success():
//           fail("Esperava que login falhasse");
//       }
//     },
//   );

//   test("UserService - Sessão anterior é identificada", () async {
//     // Arrange
//     when(mockAuth.currentUser).thenReturn(
//       User(
//         id: "111",
//         appMetadata: {},
//         userMetadata: {},
//         aud: "111",
//         createdAt: "2026-01-01",
//       ),
//     );

//     when(supabase.from('users')).thenAnswer(
//       (_) => FakeQueryBuilder([
//         {
//           "id": "111",
//           "role": "admin",
//           "nome": "João Silva",
//           "telefone": "61999999999",
//           "cpf": "99999999999",
//           "email": "teste@teste.com",
//         },
//       ]),
//     );

//     // Act
//     final result = await userService.isLoggedIn();

//     // Assert
//     expect((result as Success<bool>).value, isTrue);
//     expect(userService.localUser?.nome, "João Silva");
//     expect(userService.localUser?.role, Role.admin);
//   });

//   test("UserService - Sessão anterior inválida é identificada", () async {
//     // Arrange
//     when(mockAuth.currentUser).thenReturn(null);

//     // Act
//     final result = await userService.isLoggedIn();

//     // Assert
//     expect((result as Success<bool>).value, isFalse);
//   });
// }
