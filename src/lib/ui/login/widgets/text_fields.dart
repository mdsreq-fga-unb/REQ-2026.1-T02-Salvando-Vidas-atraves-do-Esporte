import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class EmailTextField extends ConsumerWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      onChanged: (value) =>
          ref.read(loginFormProvider.notifier).updateEmail(value),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: LoginDecorations.baseInputDecoration.copyWith(
        hintText: 'Insira aqui seu e-mail',
        errorText: ref.watch(loginFormProvider).emailError,
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey, size: 28),
      ),
    );
  }
}

class SenhaTextField extends ConsumerStatefulWidget {
  const SenhaTextField({super.key});

  @override
  ConsumerState<SenhaTextField> createState() => _SenhaTextFieldState();
}

class _SenhaTextFieldState extends ConsumerState<SenhaTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (v) =>
          this.ref.read(loginFormProvider.notifier).updateSenha(v),
      obscureText: _isObscure,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      decoration: LoginDecorations.baseInputDecoration.copyWith(
        hintText: 'Insira aqui sua senha',
        errorText: this.ref.watch(loginFormProvider).senhaError,
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey, size: 28),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
