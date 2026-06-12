import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: LoginDecorations.pageBackground,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BannerLogo(),
                    const SizedBox(height: 28),
                    FormularioLogin(),
                    const SizedBox(height: 18),
                    BotaoEntrar(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
