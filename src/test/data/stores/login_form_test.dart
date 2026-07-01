import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/stores/login/login_form.dart';

void main() {
  group('LoginForm Store Tests', () {
    test('build, updates and validation', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(loginFormProvider.notifier);
      expect(container.read(loginFormProvider).canLogin, isFalse);

      notifier.updateEmail('invalido');
      expect(container.read(loginFormProvider).emailError, isNotNull);

      notifier.updateEmail('valid@email.com');
      notifier.updateSenha('123456');

      final state = container.read(loginFormProvider);
      expect(state.canLogin, isTrue);
      expect(state.emailError, isNull);
      expect(state.senhaError, isNull);

      notifier.updateSenha('');
      notifier.validateForm();
      expect(container.read(loginFormProvider).senhaError, isNotNull);
    });
  });
}
