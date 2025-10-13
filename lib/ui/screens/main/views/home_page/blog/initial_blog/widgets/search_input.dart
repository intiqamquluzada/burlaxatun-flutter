import 'package:flutter/material.dart';

import '../../../../../../../widgets/global_input.dart';

class SearchInput extends StatelessWidget {
  final Function(String)? onSearchChanged;
  const SearchInput({super.key, this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return GlobalInput(
      prefixIcon: 'assets/icons/search_icon.svg',
      hintText: 'Axtarış...',
      onChanged: onSearchChanged,
    );
  }
}
