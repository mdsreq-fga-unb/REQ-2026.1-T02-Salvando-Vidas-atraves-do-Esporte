import '../test_imports.dart';

// void main() {
//   test('LoginFormStore valida email e senha', () async {
//     final store = LoginFormStore();
//     store.setupValidations();

//     addTearDown(store.dispose);

//     store.email = 'invalido';
//     store.senha = 'SenhaTeste';

//     await Future<void>.delayed(Duration.zero);

//     expect(store.error.email, 'Não é um email válido');
//     expect(store.error.senha, isNull);
//     expect(store.canLogin, isFalse);

//     store.senha = '';

//     await Future<void>.delayed(Duration.zero);

//     expect(store.error.senha, 'Não pode estar em branco');
//     expect(store.canLogin, isFalse);

//     store.email = 'teste@teste.com';
//     store.senha = 'SenhaTeste';

//     await Future<void>.delayed(Duration.zero);

//     expect(store.error.email, isNull);
//     expect(store.error.senha, isNull);
//     expect(store.canLogin, isTrue);
//   });
// }
