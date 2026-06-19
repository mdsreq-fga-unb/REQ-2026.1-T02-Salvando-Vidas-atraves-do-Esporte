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
                child: Text('Login', style: LoginTextStyles.formTitle),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Email', style: LoginTextStyles.formLabel),
            const SizedBox(height: 6),
            EmailTextField(),
            const SizedBox(height: 18),
            const Text('Senha', style: LoginTextStyles.formLabel),
            const SizedBox(height: 6),
            SenhaTextField(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}