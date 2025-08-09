import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String imagePath;

  const ArticleDetailsAppbar({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 182,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Image.asset(
                  'assets/png/Burla_Xatun_splash_screen.png',
                );
              },
            ),
          ),
          Positioned(
            top: 26,
            left: 15,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 182);
}
