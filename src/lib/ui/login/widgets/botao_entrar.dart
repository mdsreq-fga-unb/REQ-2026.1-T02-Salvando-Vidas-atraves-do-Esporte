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
            switch (await context.read<UserService>().login(
              store.email,
              store.senha,
            )) {
              case Failure(message: final m, error: final e):
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(m)));
                context.read<Logger>().e(m, error: e);
              case Success(value: final v):
                if (v) context.go(Routes.home);
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
