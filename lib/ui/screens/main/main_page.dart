import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/global_bottom_navbar/global_bottom_navbar.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required this.navigationShell,
    required this.shellContext,
  });

  final StatefulNavigationShell navigationShell;
  final BuildContext shellContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: navigationShell, // (navigationShell pagelerdir)
      bottomNavigationBar:
          SafeArea(child: GlobalBottomNavbar(navigationShell: navigationShell)),
    );
  }
}
