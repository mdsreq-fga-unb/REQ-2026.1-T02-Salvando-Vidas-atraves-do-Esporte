import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/login/login_controller.dart';
import 'package:salvando_vidas/data/stores/login/login_form.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class BotaoEntrar extends ConsumerWidget {
  final GlobalKey<FormState> formKey; // Exigimos a chave

  const BotaoEntrar({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(loginControllerProvider, (previous, next) {
      if (next.hasError) {
        final errorMessage = next.error.toString();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
        ref.read(loggerProvider).e(errorMessage, error: next.error);
      } else if (next.value == true) {
        context.go(Routes.home);
      }
    });

    final loginState = ref.watch(loginControllerProvider);

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: loginState.isLoading
            ? null
            : () {
                ref.read(loginFormProvider.notifier).validateForm();
                if (formKey.currentState?.validate() ?? false) {
                  ref.read(loginControllerProvider.notifier).submitLogin();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.cyanPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Colors.black45,
        ),
        child: loginState.isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}