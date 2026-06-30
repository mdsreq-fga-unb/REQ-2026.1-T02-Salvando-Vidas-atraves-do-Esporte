import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.color,
    this.gradientColors,
    this.subtitle,
  });

  final String title;
  final String value;
  final Color? color;
  final List<Color>? gradientColors;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool hasGradient = gradientColors != null && gradientColors!.length >= 2;
    final bool colored = hasGradient || (color != null && color != Colors.white);
    
    final cardBg = hasGradient ? null : (colored ? color : (isDark ? AppColors.darkSurface : Colors.white));
    final textColor = colored ? Colors.white : (isDark ? Colors.white : AppColors.deepNavy);
    final subColor = colored ? Colors.white.withValues(alpha: 0.9) : (isDark ? Colors.white70 : AppColors.textSecondary);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: cardBg,
        gradient: hasGradient
            ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(14),
        boxShadow: hasGradient
            ? [
                BoxShadow(
                  color: gradientColors!.first.withOpacity(isDark ? 0.45 : 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ]
            : AppColors.cardShadow(isDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        mainAxisAlignment: MainAxisAlignment.center, 
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center, 
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center, 
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w900,
                fontSize: 26,
              ),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: subColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}