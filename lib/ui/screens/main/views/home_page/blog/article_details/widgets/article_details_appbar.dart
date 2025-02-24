import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleDetailsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const ArticleDetailsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 74),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_back_ios_new_rounded),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Image.asset(
                'assets/png/postnatal.png',
                scale: 2.9,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 74),
              child: SizedBox(
                width: 44,
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.more_vert_rounded),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 175);
}
