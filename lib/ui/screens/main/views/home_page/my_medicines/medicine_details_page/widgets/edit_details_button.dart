import 'package:burla_xatun/data/models/remote/response/medicine/medicines_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../widgets/global_text.dart';

class EditDetailsButton extends StatelessWidget {
  final Result data;
  final ValueChanged<Result>? onUpdated;

  const EditDetailsButton({
    super.key,
    required this.data,
    this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return SizedBox(
      height: 48,
      width: 117,
      child: ElevatedButton(
        style: ButtonStyle(
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          side: WidgetStatePropertyAll(
            BorderSide(color: ColorConstants.primaryRedColor),
          ),
        ),
        onPressed: () async {
          final result = await mainCubit.showEditMedicine(context, data);
          if (result != null) {
            onUpdated?.call(result);
          }
        },
        child: GlobalText(
          text: 'Düzəliş et',
          fontSize: 14,
          height: 1.1,
          fontWeight: FontWeight.w500,
          color: ColorConstants.primaryRedColor,
        ),
      ),
    );
  }
}
