import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/main_imports.dart';
import '../login_imports.dart';

class BotaoEntrar extends ConsumerWidget {
  const BotaoEntrar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Ouvimos o resultado do login para ações de UI (Rotas e Alertas)
    ref.listen<AsyncValue<bool>>(loginControllerProvider, (previous, next) {
      if (next.hasError) {
        // Se ocorreu um erro, pega a mensagem do nosso AppApiException e exibe
        final errorMessage = next.error.toString();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
        ref.read(loggerProvider).e(errorMessage, error: next.error);
      } else if (next.value == true) {
        // Se logou com sucesso, redireciona
        context.go(Routes.home);
      }
    });

    // 2. Lemos o estado atual do controller (para Loading) e do Form (para habilitar o botão)
    final loginState = ref.watch(loginControllerProvider);
    final formState = ref.watch(loginFormProvider);

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        // Desabilita se estiver carregando OU se o form tiver erros
        onPressed: loginState.isLoading || !formState.canLogin
            ? null
            : () {
                // Chama o controller que fará o gerenciamento seguro da requisição
                ref.read(loginControllerProvider.notifier).submitLogin();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: LoginColors.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: LoginTextStyles.buttonText,
        ),
        // Mostra um spinner visual automático se estiver em loading
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
