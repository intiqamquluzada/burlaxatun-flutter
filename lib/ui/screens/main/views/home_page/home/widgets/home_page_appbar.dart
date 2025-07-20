import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:burla_xatun/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class HomePageAppbar extends StatefulWidget implements PreferredSizeWidget {
  const HomePageAppbar({super.key});

  @override
  State<HomePageAppbar> createState() => _HomePageAppbarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 95);
}

class _HomePageAppbarState extends State<HomePageAppbar> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20) +
          EdgeInsets.only(top: context.statusBarTopHeight + 14),
      child: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (_, state) {
          if (state.status == UserDataStatus.loading) {
            return const Center(child: CustomCircularProgressIndicator());
          }

          if (state.status == UserDataStatus.failure) {
            return const Center(child: Text('Xəta'));
          }

          if (state.status == UserDataStatus.networkError) {
            return const Center(child: Text('Şəbəkə xətası'));
          }

          if (state.status == UserDataStatus.success &&
              state.response != null) {
            final data = state.response!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GlobalText(
                          text: 'Salam, ${data.fullName ?? 'İstifadəçi'}',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff8C8A8A),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: SvgPicture.asset(
                              'assets/icons/notification_bing.svg'),
                          onTap: () {
                            context.push('/notification');
                          },
                        ),
                        // const SizedBox(width: 25),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 8),
                        //   child: SvgPicture.asset(
                        //       'assets/icons/side_navbar_icon.svg'),
                        // ),
                      ],
                    ),
                  ],
                ),
                !data.isPregnant!
                    ? GlobalText(
                        textAlign: TextAlign.left,
                        height: 1.3,
                        text:
                            '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )
                    : GlobalText(
                        textAlign: TextAlign.left,
                        height: 1.3,
                        text:
                            'Hamiləliyin ${data.pregnantWeek ?? '0'}. həftəsi \nGün ${(int.tryParse(data.pregnantWeek ?? '0') ?? 0) * 7}',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
