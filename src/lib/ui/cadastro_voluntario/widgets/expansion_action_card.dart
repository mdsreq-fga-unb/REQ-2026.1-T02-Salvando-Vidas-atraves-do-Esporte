import 'package:flutter/material.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

class ExpansionActionCard extends StatelessWidget {
  const ExpansionActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.expanded,
    required this.onToggle,
    required this.child,
    this.backgroundColor,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = backgroundColor ?? (isDark ? AppColors.darkSurface : AppColors.cyanPastel.withValues(alpha: 0.2));
    final titleColor = isDark ? Colors.white : AppColors.deepNavy;
    final subColor = isDark ? Colors.white70 : AppColors.deepNavy;
    final expandedBg = isDark ? const Color(0xFF161B22) : Colors.white;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onToggle,
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.royalAzure,
                ),
              ),
            ],
          ),
          if (expanded) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: expandedBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: child,
            ),
          ],
        ],
      ),
    );
  }
}
