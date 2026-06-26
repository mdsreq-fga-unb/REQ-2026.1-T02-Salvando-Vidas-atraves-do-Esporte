import 'package:salvando_vidas/main_imports.dart';
import '../login_imports.dart';

class FormularioLogin extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const FormularioLogin({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      decoration: LoginDecorations.formContainer,
      child: Form(
        key: formKey,
        // Só valida automaticamente DEPOIS do primeiro clique no botão entrar
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'E-mail:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const EmailTextField(),
            const SizedBox(height: 24),
            const Text(
              'Senha:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const SenhaTextField(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}