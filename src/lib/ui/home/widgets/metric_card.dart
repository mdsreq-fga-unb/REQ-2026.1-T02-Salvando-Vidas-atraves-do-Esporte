import 'package:salvando_vidas/main_imports.dart';

class MetricCard extends StatelessWidget {

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.width,
  });

  final String title;
  final String value;
  final Color color;
  final double width;

  @override
  Widget build(BuildContext context) {
    final bool colored = color != Colors.white;
    return Container(
      width: width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colored ? color : Colors.white,
        borderRadius:
            BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 8,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colored ? Colors.white : const Color(0xFF08216F),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: colored ? Colors.white : const Color(0xFF08216F),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}