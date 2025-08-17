import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../utils/constants/padding_constants.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import 'widgets/countries_and_selecteds_box.dart';
import 'widgets/countries_widget.dart';
import 'widgets/selected_names_widget.dart'; 

class NamesPage extends StatefulWidget {
  const NamesPage({super.key});

  @override
  State<NamesPage> createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage> {
  late PageController _pageController;
  late ValueNotifier<int> countriesOrSelectedNamesScreen;
  @override
  void initState() {
    countriesOrSelectedNamesScreen = ValueNotifier<int>(0);
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Adlar ',
        onLeadingTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: PaddingConstants.h20,
        child: Center(
          child: Column(
            children: [
              14.h,
              CountriesAndSelectedsBox(
                countriesOrSelectedNamesScreen: countriesOrSelectedNamesScreen,
                pageController: _pageController,
              ),
              24.h,
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CountriesWidget(),
                    SelectedNamesWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
