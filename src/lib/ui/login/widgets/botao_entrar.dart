import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/data/stores/login/login_controller.dart';
import 'package:salvando_vidas/main_imports.dart';
import '../login_imports.dart';

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
      height: 56,
      child: ElevatedButton(
        // MÁGICA 3: Se não estiver carregando, o botão fica SEMPRE ativo!
        onPressed: loginState.isLoading
            ? null
            : () {
                // MÁGICA 4: Ao clicar, ele grita para os TextFields: "Tem erro aí?!"
                if (formKey.currentState?.validate() ?? false) {
                  // Se não tem erro visual, manda pro backend
                  ref.read(loginControllerProvider.notifier).submitLogin();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: LoginColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: LoginTextStyles.buttonText,
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
            : const Text('Entrar'),
      ),
    );
  }
}