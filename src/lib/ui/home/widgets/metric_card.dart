import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    this.subtitle, // Opcional, sem 'required'
  });

  final String title;
  final String value;
  final Color color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final bool colored = color != Colors.white;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colored ? color : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 8,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Text(
            title,
            textAlign: TextAlign.center, 
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colored ? Colors.white : AppColors.deepNavy,
              fontSize: 11, // Reduzido levemente para ganhar espaço
            ),
          ),
          const SizedBox(height: 2), // Reduzido de 4 para 2
          FittedBox( // Garante que o valor principal sempre caiba no card
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center, 
              style: TextStyle(
                color: colored ? Colors.white : AppColors.deepNavy,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2), // Reduzido de 4 para 2
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colored ? Colors.white.withOpacity(0.9) : AppColors.textSecondary,
                fontSize: 9, // Reduzido levemente para ganhar espaço
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}