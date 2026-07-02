import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

import '../login_imports.dart';

class EmailTextField extends ConsumerWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final fillColor = isDark ? const Color(0xFF161B22) : const Color(0xFFEBEBEB);

    return TextFormField(
      onChanged: (value) =>
          ref.read(loginFormProvider.notifier).updateEmail(value),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: LoginDecorations.baseInputDecoration.copyWith(
        hintText: 'Insira aqui seu e-mail',
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey, fontSize: 14),
        fillColor: fillColor,
        errorText: ref.watch(loginFormProvider).emailError,
        prefixIcon: Icon(Icons.email_outlined, color: isDark ? AppColors.cyanPrimary : Colors.grey, size: 28),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final fillColor = isDark ? const Color(0xFF161B22) : const Color(0xFFEBEBEB);

    return TextFormField(
      onChanged: (v) =>
          ref.read(loginFormProvider.notifier).updateSenha(v),
      obscureText: _isObscure,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
      ),
      decoration: LoginDecorations.baseInputDecoration.copyWith(
        hintText: 'Insira aqui sua senha',
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey, fontSize: 14),
        fillColor: fillColor,
        errorText: ref.watch(loginFormProvider).senhaError,
        prefixIcon: Icon(Icons.lock_outline, color: isDark ? AppColors.cyanPrimary : Colors.grey, size: 28),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
          icon: Icon(
            _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: isDark ? Colors.white70 : Colors.grey,
          ),
        ),
      ),
    );
  }
}
