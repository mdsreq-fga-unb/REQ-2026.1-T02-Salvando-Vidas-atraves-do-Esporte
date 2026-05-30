import '../test_imports.dart';

import 'package:salvando_vidas/data/stores/login/login_form.dart';

void main() {
  test('LoginFormStore valida email e senha', () async {
    final store = LoginFormStore();
    store.setupValidations();

    addTearDown(store.dispose);

    store.email = 'invalido';
    store.password = 'SenhaTeste';

    await Future<void>.delayed(Duration.zero);

    expect(store.error.email, 'Não é um email válido');
    expect(store.error.password, isNull);
    expect(store.canLogin, isFalse);

    store.password = '';

    await Future<void>.delayed(Duration.zero);

    expect(store.error.password, 'Não pode estar em branco');
    expect(store.canLogin, isFalse);

    store.email = 'teste@teste.com';
    store.password = 'SenhaTeste';

    await Future<void>.delayed(Duration.zero);

    expect(store.error.email, isNull);
    expect(store.error.password, isNull);
    expect(store.canLogin, isTrue);
  });
}
