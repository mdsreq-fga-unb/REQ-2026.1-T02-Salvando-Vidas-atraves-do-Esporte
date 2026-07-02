import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../data/services/user_service/user_service.dart';
import '../../../domain/local_user/local_user.dart';
import '../../../routing/routes.dart';
import '../themes/colors.dart';

class TopBar extends ConsumerWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localUser = ref.watch(localUserProvider);
    final isAdmin = localUser?.role == Role.admin;
    final location = GoRouterState.of(context).uri.path;
    final isAdminPage = location.startsWith(Routes.admin);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final topbarColor = isDark ? AppColors.darkTopbar : AppColors.cyanPrimary;
    final logoTextColor = isDark ? AppColors.cyanPastel : AppColors.deepNavy;
    final logoSplash = isDark
        ? AppColors.cyanPastel.withOpacity(0.15)
        : AppColors.deepNavy.withOpacity(0.2);

    return Container(
      color: topbarColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => context.go(Routes.home),
                splashColor: logoSplash,
                highlightColor: logoSplash.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: isDark
                      ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
                      : const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: isDark
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        )
                      : null,
                  child: Image.asset(
                    'assets/images/logoMestre.png',
                    height: isDark ? 32 : 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              if (isAdmin)
                Tooltip(
                  message: isAdminPage ? 'Você está no painel admin' : 'Acessar painel admin',
                  decoration: BoxDecoration(
                    color: AppColors.deepNavy,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isAdminPage ? Colors.white.withOpacity(0.2) : Colors.transparent,
                      border: Border.all(
                        color: isAdminPage ? Colors.white : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: isAdminPage ? null : () => context.go(Routes.admin),
                        splashColor: Colors.white24,
                        highlightColor: Colors.white10,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Icons.admin_panel_settings,
                            color: isAdminPage ? Colors.white : Colors.white.withOpacity(0.7),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
