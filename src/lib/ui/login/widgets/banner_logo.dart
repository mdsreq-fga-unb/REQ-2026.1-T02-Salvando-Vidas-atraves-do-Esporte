import 'package:salvando_vidas/main_imports.dart';

import '../login_imports.dart';

class BannerLogo extends StatelessWidget {
  const BannerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 148,
      decoration: BoxDecoration(
        color: LoginColors.primaryCyan,
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
      child: const Text(
        'Logo',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
