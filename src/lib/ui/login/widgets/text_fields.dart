import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class EmailTextField extends StatelessWidget {
  final LoginFormStore store;
  const EmailTextField(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        decoration: LoginDecorations.inputContainerShadow,
        child: TextFormField(
          onChanged: (value) => store.email = value,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          decoration: LoginDecorations.baseInputDecoration.copyWith(
            hintText: 'Insira aqui seu email',
            errorText: store.error.email,
            prefixIcon: Container(
              width: 54,
              margin: const EdgeInsets.only(right: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(34),
                ),
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
      ),
    );
  }
}

class SenhaTextField extends StatefulWidget {
  final LoginFormStore store;

  const SenhaTextField(this.store, {super.key});

  @override
  State<SenhaTextField> createState() => _SenhaTextFieldState();
}

class _SenhaTextFieldState extends State<SenhaTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LoginDecorations.inputContainerShadow,
      child: TextFormField(
        onChanged: (value) => widget.store.password = value,
        obscureText: _isObscure,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: LoginDecorations.baseInputDecoration.copyWith(
          hintText: 'Insira aqui sua senha',
          errorText: widget.store.error.password,
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
