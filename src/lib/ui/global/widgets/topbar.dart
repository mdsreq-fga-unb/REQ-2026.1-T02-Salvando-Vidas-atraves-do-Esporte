import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/routes.dart';

class TopBar extends StatelessWidget
    implements PreferredSizeWidget {

  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: const Color(0xFF10A9D0),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10,),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(// LOGO
                onTap: () {context.go(Routes.home);},
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: Image.asset(
                    'assets/images/logoMestre.png',
                    fit: BoxFit.contain,
                  )
                ),
              ),
              // Botão de notificações
              GestureDetector(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize =>
      const Size.fromHeight(64);
}