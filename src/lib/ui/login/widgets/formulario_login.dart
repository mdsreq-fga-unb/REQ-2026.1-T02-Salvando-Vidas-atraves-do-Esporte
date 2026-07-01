import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import '../login_imports.dart';

class FormularioLogin extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const FormularioLogin({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppColors.cardShadow(isDark),
      ),
      child: Form(
        key: formKey,
        // Só valida automaticamente DEPOIS do primeiro clique no botão entrar
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'E-mail:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            const EmailTextField(),
            const SizedBox(height: 24),
            Text(
              'Senha:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textColor,
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