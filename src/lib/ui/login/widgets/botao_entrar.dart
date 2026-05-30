import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class BotaoEntrar extends StatelessWidget {
  final LoginFormStore store;
  const BotaoEntrar(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () async {
          if (store.canLogin) {
            try {
              final loggedin = await context.read<UserService>().login(
                store.email,
                store.senha,
              );
              if (context.mounted && loggedin) {
                context.go(Routes.home);
              }
            } on AuthApiException catch (e) {
              if (context.mounted) {
                context.read<Logger>().e("Erro ao autenticar", error: e);
              }
            }
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
        child: const Text('Entrar'),
      ),
    );
  }
}
