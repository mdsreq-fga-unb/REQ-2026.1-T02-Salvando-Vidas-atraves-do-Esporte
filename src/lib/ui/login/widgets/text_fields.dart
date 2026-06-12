import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class EmailTextField extends ConsumerWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: LoginDecorations.inputContainerShadow,
      child: TextFormField(
        onChanged: (value) =>
            ref.read(loginFormProvider.notifier).updateEmail(value),
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: LoginDecorations.baseInputDecoration.copyWith(
          hintText: 'Insira aqui seu email',
          errorText: ref.watch(loginFormProvider).emailError,
          prefixIcon: Container(
            width: 54,
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(34)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF11A6BF), Color(0xFF6EC8D6)],
              ),
            ),
            child: const Icon(Icons.email_outlined, color: Color(0xFF1E2B61)),
          ),
        ),
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
    return Container(
      decoration: LoginDecorations.inputContainerShadow,
      child: TextFormField(
        onChanged: (v) =>
            this.ref.read(loginFormProvider.notifier).updateSenha(v),
        obscureText: _isObscure,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: LoginDecorations.baseInputDecoration.copyWith(
          hintText: 'Insira aqui sua senha',
          errorText: this.ref.watch(loginFormProvider).senhaError,
          prefixIcon: Container(
            width: 54,
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(34)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF11A6BF), Color(0xFF6EC8D6)],
              ),
            ),
            child: const Icon(Icons.lock_outline, color: Color(0xFF1E2B61)),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
          ),
        ),
      ),
    );
  }
}
