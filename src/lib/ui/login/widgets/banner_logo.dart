import 'package:salvando_vidas/main_imports.dart';

class BannerLogo extends StatelessWidget {
  const BannerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logoMestre.png',
      height: 200, // Logo maior e transparente conforme a imagem
      fit: BoxFit.contain,
    );
  }
}