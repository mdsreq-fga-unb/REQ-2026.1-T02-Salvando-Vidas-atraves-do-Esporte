import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class FormularioLogin extends StatelessWidget {
  final LoginFormStore store;
  const FormularioLogin(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      decoration: LoginDecorations.formContainer,
      child: Form(
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
            EmailTextField(store),
            const SizedBox(height: 18),
            const Text('Senha', style: LoginTextStyles.formLabel),
            const SizedBox(height: 6),
            SenhaTextField(store),
            const SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: TextButton(
            //     onPressed: () {},
            //     style: TextButton.styleFrom(
            //       foregroundColor: const Color(0xFFB9C8FF),
            //       padding: EdgeInsets.zero,
            //       minimumSize: Size.zero,
            //       tapTargetSize:
            //           MaterialTapTargetSize.shrinkWrap,
            //     ),
            //     child: const Text(
            //       'Esqueceu sua Senha?',
            //       style: TextStyle(fontSize: 12),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
