import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class BannerLogo extends StatelessWidget {
  const BannerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      height: 148,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: LoginColors.shadowLight,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/logoMestre.png',
        height: 120,
        fit: BoxFit.contain,
      ),
    );
  }
}