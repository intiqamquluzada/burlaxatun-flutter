import 'dart:developer';

import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../cubits/add_child/add_child_cubit.dart';
import '../../../cubits/questions_cubit/questions_cubit.dart';
import '../../../cubits/questions_cubit/questions_state.dart';
import '../../../cubits/user_data/user_data_cubit.dart';
import '../../../data/models/remote/request/add_child_request_model.dart';
import '../../../utils/constants/asset_constants.dart';
import '../../../utils/constants/color_constants.dart';
import '../../../utils/extensions/context_extensions.dart';
import '../../../utils/extensions/num_extensions.dart';
import '../../widgets/global_appbar.dart';
import '../../widgets/global_input.dart';
import '../../widgets/global_text.dart';
import '../questions/widgets/question_views/davam_et_button.dart';
import '../questions/widgets/question_views/pick_birth_date_widget.dart';
import 'widgets/add_child_success_dialog.dart';

class AddYourChild extends StatelessWidget {
  const AddYourChild({
    super.key,
    this.isChangeProfile = false,
  });

  final bool isChangeProfile;

  @override
  Widget build(BuildContext context) {
    final questionCubit = context.read<QuestionsCubit>();
    final addChildCubit = context.read<AddChildCubit>();
    final userDataCubit = context.read<UserDataCubit>();

    //  context.read<UserDataCubit>();
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Övladınızı əlavə edin',
        onLeadingTap: () {
          context.pop();
        },
        leading: isChangeProfile ? null : SizedBox.shrink(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColoredBox(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  spacing: context.deviceHeight < 700 ? 15 : 20,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.deviceHeight < 710 ? 14 : 28),
                      child: GlobalText(
                        text: 'Övladınızı əlavə edin',
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    GlobalInput(
                      onFieldSubmitted: (v) {
                        questionCubit.showBirthDateBottomSheet(
                          context,
                          PickBirthDateWidget(),
                        );
                      },
                      textController: addChildCubit.childFullNameController,
                      inputName: 'Tam Ad',
                      prefixIcon: AssetConstants.userChildIcon,
                      hintText: 'Tam adını qeyd edin',
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: 'Doğum Tarixi',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        context.deviceHeight < 750 ? 8.h : 16.h,
                        GestureDetector(
                          onTap: () {
                            questionCubit.showBirthDateBottomSheet(
                              context,
                              PickBirthDateWidget(),
                            );
                          },
                          child: SizedBox(
                            width: context.deviceWidth,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(34)),
                                border: Border.all(
                                  color: ColorConstants.enabledInputColor,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16) +
                                        EdgeInsets.only(left: 16),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/calendar_svg.svg'),
                                    SizedBox(width: 12),
                                    BlocBuilder<QuestionsCubit,
                                        QuestionsInitial>(
                                      buildWhen: (previous, current) {
                                        return previous.birthDateString !=
                                            current.birthDateString;
                                      },
                                      builder: (context, state) {
                                        return GlobalText(
                                          text: state.birthDateString,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: state.birthDateString ==
                                                  'Tarixi seçin...'
                                              ? ColorConstants.hintTextColor
                                              : Colors.black,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GlobalInput(
                      textController: addChildCubit.childWeightController,
                      focusNode: questionCubit.childWeightFocusNode,
                      inputName: 'Çəki',
                      prefixIcon: AssetConstants.weightIcon,
                      hintText: 'Çəkisini qeyd edin (kq ilə)',
                      isNumber: true,
                      onFieldSubmitted: (v) {
                        questionCubit.childHeightFocusNode.requestFocus();
                      },
                    ),
                    GlobalInput(
                      textController: addChildCubit.childHeightController,
                      focusNode: questionCubit.childHeightFocusNode,
                      inputName: 'Boy',
                      prefixIcon: AssetConstants.heightIcon,
                      isNumber: true,
                      hintText: 'Boyunu qeyd edin (sm ilə)',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: BlocConsumer<AddChildCubit, AddChildState>(
              buildWhen: (previous, current) {
                return previous.addChildStatus != current.addChildStatus;
              },
              listener: (context, state) {
                if (state.addChildStatus == AddChildStatus.error) {
                  log('Uşaq əlavə edərkən xəta baş verdi');
                } else if (state.addChildStatus ==
                    AddChildStatus.networkError) {
                  ('Şəbəkə xətası');
                } else if (state.addChildStatus == AddChildStatus.success) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AddChildSuccessDialog(
                        isChangeProfile: isChangeProfile,
                        text: 'Övladınız uğurla əlavə olundu',
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                final babyName =
                    addChildCubit.childFullNameController.text.trim();
                final babyBirthDate = questionCubit.state.birthDateString;
                final babyWeight =
                    addChildCubit.childWeightController.text.trim();
                final babyHeight =
                    addChildCubit.childHeightController.text.trim();
                return DavamEt(
                  isLoading: state.addChildStatus == AddChildStatus.loading,
                  isActive: true,
                  onPressed: () async {
                    if (babyName.isEmpty ||
                        babyHeight.isEmpty ||
                        babyWeight.isEmpty) {
                      AppSnackbars.error(context, 'Bütün xanaları doldurun');
                      return;
                    }
                    final childData = AddChildRequestModel(
                      name: babyName,
                      weight: babyWeight,
                      height: babyHeight,
                      birthDate: babyBirthDate,
                    );
                    await addChildCubit.addChild(childData: childData);
                    await userDataCubit.getUserData();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
