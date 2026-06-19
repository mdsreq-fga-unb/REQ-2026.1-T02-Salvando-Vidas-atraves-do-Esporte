import 'package:salvando_vidas/main_imports.dart';
import '../login_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // MÁGICA 1: Criamos a chave Mestra aqui!
  final _formKey = GlobalKey<FormState>();

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
                    // Passamos a chave para o formulário
                    FormularioLogin(formKey: _formKey),
                    const SizedBox(height: 18),
                    // Passamos a mesma chave para o botão
                    BotaoEntrar(formKey: _formKey),
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