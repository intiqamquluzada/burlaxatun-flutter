import 'package:burla_xatun/cubits/main_cubit/mainn_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../../../../utils/constants/color_constants.dart';
import '../../../../../../utils/constants/padding_constants.dart';
import '../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../widgets/global_button.dart';
import '../../../../../widgets/global_text.dart';

class CalculationResultDialog extends StatelessWidget {
  const CalculationResultDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final questionsCubit = context.read<QuestionsCubit>();
    return PopScope(
      canPop: false,
      child: Center(
        child: SizedBox(
          width: context.deviceWidth * 0.78,
          height: context.deviceHeight * 0.45,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(38)),
            ),
            child: Padding(
              padding: PaddingConstants.v20 + PaddingConstants.h15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // AppleCircle(),
                        // Transform.rotate(
                        //   angle: -math.pi,
                        //   child: SvgPicture.asset(
                        //     AssetConstants.arrowLeft,
                        //   ),
                        // ),
                        // SvgPicture.asset(
                        //   AssetConstants.arrowRight,
                        // ),
                        // 10.w,
                        CachedNetworkImage(
                          imageUrl:
                              questionsCubit.calculatedData.data?.iconUrl2 ??
                                  '',
                          width: 100,
                          height: 100,
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error);
                          },
                        ),
                        // SvgPicture.asset(
                        //   AssetConstants.baby,
                        //   width: context.deviceWidth * 0.69,
                        //   height: context.deviceHeight * 0.12,
                        // )
                      ],
                    ),
                  ),
                  (context.deviceHeight * 0.04).h,
                  GlobalText(
                    text:
                        'Siz hamiləliyinizin ${questionsCubit.calculatedData.data?.weeks} həftəsindəsiniz',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                  12.h,
                  GlobalText(
                    text:
                        'Körpəniz isə ${questionsCubit.calculatedData.data?.iconName} boydadır!',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  12.h,
                  GlobalButton(
                    buttonName: 'Davam et',
                    textFSize: 14,
                    textHeight: 0,
                    buttonColor: ColorConstants.primaryRedColor,
                    textColor: Colors.white,
                    height: 44,
                    onPressed: () {
                      context.go(
                          '/home?reset=${DateTime.now().millisecondsSinceEpoch}');
                      // context.go('/home');
                      context.read<MainCubit>().changeView(0);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
