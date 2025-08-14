import 'package:burla_xatun/cubits/main_cubit/mainn_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/asset_constants.dart';
import '../../../../utils/extensions/num_extensions.dart';
import '../../../widgets/global_text.dart';
import 'question_views/davam_et_button.dart';

class SuccessAddPregnancyPage extends StatelessWidget {
  const SuccessAddPregnancyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              ColoredBox(
                color: Colors.transparent,
                child: SvgPicture.asset(AssetConstants.successImage),
              ),
              75.h,
              SizedBox(
                width: 318,
                child: GlobalText(
                  textAlign: TextAlign.center,
                  text: 'Hamiləlik uğurla əlavə olundu!',
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: DavamEt(
                  isActive: true,
                  onPressed: () {
                    context.go('/home');
                    context.read<MainCubit>().changeView(0);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
