import 'dart:developer';

import 'package:burla_xatun/cubits/questions_cubit/questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants/color_constants.dart';
import '../../../../../utils/constants/padding_constants.dart';
import '../../../../widgets/global_button.dart';

class DavamEt extends StatelessWidget {
  const DavamEt({
    super.key,
    this.isActive = false,
    this.onPressed,
    this.isLoading = false,
  });

  final bool isActive;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: PaddingConstants.h20,
        child: GlobalButton(
          isLoading: isLoading,
          buttonName: 'Davam et',
          buttonColor:
              isActive ? ColorConstants.primaryRedColor : Colors.black38,
          textColor: Colors.white,
          onPressed: isActive ? onPressed : null,
        ),
      ),
    );
  }
}
