import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../../data/models/local/my_healing_card_items_model.dart';
import '../../../../../../../widgets/global_text.dart';

class SingleIndicatorTile extends StatelessWidget {
  const SingleIndicatorTile({
    super.key,
    required this.item,
  });

  final MyHealingCardItemsModel item;

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          if (item.indciatorName == 'medicines') {
            mainCubit.pushScaffoldMyMedicinesPage(context);
          } else {
            context.push(
              '/indicator_data',
              extra: {
                'indicator': item.indciatorName,
                'indicator_name': item.tileName,
              },
            );
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SvgPicture.asset(item.icon, width: 24, height: 24),
                SizedBox(width: 16),
                GlobalText(
                  text: item.tileName,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                Spacer(),
                SvgPicture.asset('assets/icons/arrow_right.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
