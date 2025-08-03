import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/global_bottom_navbar/global_bottom_navbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.navigationShell,
    required this.shellContext,
  });

  final StatefulNavigationShell navigationShell;
  final BuildContext shellContext;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // context.read<MainnCubit>().setNavigationShell(widget.navigationShell);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: widget.navigationShell, // navigationShell tablardir
      bottomNavigationBar: SafeArea(
        child: GlobalBottomNavbar(navigationShell: widget.navigationShell),
      ),
    );
  }
}
