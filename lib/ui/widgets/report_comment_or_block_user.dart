import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../cubits/report_or_block_user/report_or_block_user_cubit.dart';
import '../../utils/app/app_snackbars.dart';
import '../../utils/extensions/context_extensions.dart';
import '../../utils/extensions/num_extensions.dart';
import 'global_text.dart';

class ReportCommentOrBlockUser extends StatelessWidget {
  const ReportCommentOrBlockUser({
    super.key,
    required this.userId,
    required this.commentId,
  });
  final int? userId;
  final int? commentId;

  @override
  Widget build(BuildContext context) {
    final reportOrBlockCubit = context.read<ReportOrBlockUserCubit>();
    return SizedBox(
      height: 170,
      width: context.deviceWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          12.h,
          Center(
            child: Container(
              height: 5,
              width: 52,
              decoration: BoxDecoration(
                color: Color(0xff252B37),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
          ),
          6.h,
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: GlobalText(
              text: 'Rəy',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff414651),
            ),
          ),
          24.h,
          BlocConsumer<ReportOrBlockUserCubit, ReportOrBlockUserState>(
            buildWhen: (previous, current) {
              return previous.reportStatus != current.reportStatus;
            },
            listenWhen: (previous, current) {
              return previous.reportStatus != current.reportStatus;
            },
            listener: (context, state) {
              if (state.reportStatus == ReportStatus.error) {
                context.pop();
                AppSnackbars.error(
                  context,
                  state.error ?? 'Şərh üçün şikayət göndərərkən xəta baş verdi',
                );
              }
              if (state.reportStatus == ReportStatus.success) {
                context.pop();
                AppSnackbars.success(context, 'Şərh üçün şikayət olundu');
              }
            },
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  log('comment: ');
                  reportOrBlockCubit.reportComment(commentId!);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svgs/report_icon.svg'),
                      SizedBox(width: 8),
                      GlobalText(
                        text: state.reportStatus == ReportStatus.loading
                            ? 'Göndərilir...'
                            : 'Şikayət',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff252B37),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          2.h,
          Ink(
            child: BlocConsumer<ReportOrBlockUserCubit, ReportOrBlockUserState>(
              buildWhen: (previous, current) {
                return previous.blockStatus != current.blockStatus;
              },
              listenWhen: (previous, current) {
                return previous.blockStatus != current.blockStatus;
              },
              listener: (context, state) {
                if (state.blockStatus == BlockStatus.error) {
                  context.pop();
                  AppSnackbars.error(
                    context,
                    state.error ?? 'İstifadəçini blok edərkən xəta baş verdi',
                  );
                }
                if (state.blockStatus == BlockStatus.success) {
                  context.pop();
                  AppSnackbars.success(context, 'İstifadəçi bloklandı');
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    reportOrBlockCubit.blockUser(userId!);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/block_user_icon.svg'),
                        SizedBox(width: 8),
                        GlobalText(
                          text: state.blockStatus == BlockStatus.loading
                              ? 'Bloklanır...'
                              : 'İstifadəçini bloklayın',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff252B37),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
