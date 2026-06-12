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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6,),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),),
                  child: const Text('Logo', style: TextStyle(color: Color(0xFF08216F), fontWeight: FontWeight.w700,),),
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