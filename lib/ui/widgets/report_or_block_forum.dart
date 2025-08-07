import 'package:burla_xatun/cubits/report_or_block_user/report_or_block_user_cubit.dart';
import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:burla_xatun/utils/extensions/context_extensions.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ReportOrBlockForum extends StatelessWidget {
  const ReportOrBlockForum({
    super.key,
    required this.forumId,
  });

  final int? forumId;

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
              text: 'Forum',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xff414651),
            ),
          ),
          24.h,
          BlocConsumer<ReportOrBlockUserCubit, ReportOrBlockUserState>(
            buildWhen: (previous, current) {
              return previous.reportForumStatus != current.reportForumStatus;
            },
            listenWhen: (previous, current) {
              return previous.reportForumStatus != current.reportForumStatus;
            },
            listener: (context, state) {
              if (state.reportForumStatus == ReportForumStatus.error) {
                context.pop();
                AppSnackbars.error(
                  context,
                  state.error ??
                      'Forum üçün şikayət göndərərkən xəta baş verdi',
                );
              }
              if (state.reportForumStatus == ReportForumStatus.success) {
                context.pop();
                AppSnackbars.success(context, 'Forum üçün şikayət olundu');
              }
            },
            builder: (context, state) {
              return InkWell(
                onTap: () {
                  reportOrBlockCubit.reportForum(forumId: forumId!);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/svgs/report_icon.svg'),
                      SizedBox(width: 8),
                      GlobalText(
                        text:
                            state.reportForumStatus == ReportForumStatus.loading
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
                return previous.blockForumStatus != current.blockForumStatus;
              },
              listenWhen: (previous, current) {
                return previous.blockForumStatus != current.blockForumStatus;
              },
              listener: (context, state) {
                if (state.blockForumStatus == BlockForumStatus.error) {
                  context.pop();
                  AppSnackbars.error(
                    context,
                    state.error ?? 'Forumu block edərkən xəta baş verdi',
                  );
                }
                if (state.blockForumStatus == BlockForumStatus.success) {
                  context.pop();
                  AppSnackbars.success(context, 'Forum bloklandı');
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    reportOrBlockCubit.blockForum(forumId: forumId!);
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svgs/block_user_icon.svg'),
                        SizedBox(width: 8),
                        GlobalText(
                          text:
                              state.blockForumStatus == BlockForumStatus.loading
                                  ? 'Bloklanır...'
                                  : 'Forumu bloklayın',
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
