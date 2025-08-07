import 'package:burla_xatun/ui/widgets/global_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../cubits/ultrasound/ultrasound_cubit.dart';
import '../../../../../../cubits/user_data/user_data_cubit.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import 'widgets/scrollable_days_appbar.dart';
import 'widgets/selectable_ultrasound_format.dart';

class UltrasoundPage extends StatefulWidget {
  const UltrasoundPage({super.key});

  @override
  State<UltrasoundPage> createState() => _UltrasoundPageState();
}

class _UltrasoundPageState extends State<UltrasoundPage> {
  late UltrasoundCubit ultrasoundCubit;
  late ValueNotifier<int?> weekValue;
  late ScrollController scrollController;
  @override
  void initState() {
    final pregnancyWeek =
        context.read<UserDataCubit>().state.response?.pregnantWeek;
    weekValue = ValueNotifier<int?>(int.parse(pregnancyWeek ?? '0'));
    scrollController = ScrollController();

    if (pregnancyWeek == '0') return;
    ultrasoundCubit = context.read<UltrasoundCubit>()
      ..getUltraSound(week: int.parse(pregnancyWeek ?? '0'));
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     log('reached end of bar');
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: ScrollableWeeksAppBar(
          appbarName: 'Ultrasəs',
          weekValue: weekValue,
          scrollController: scrollController,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: ValueListenableBuilder(
              valueListenable: weekValue,
              builder: (context, week, child) {
                return Visibility(
                  visible: week != 0,
                  replacement: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: GlobalText(
                      textAlign: TextAlign.center,
                      text:
                          'İstənilən həftənin məlumatına baxmaq üçün həmin həftənin üzərinə toxunun',
                    ),
                  ),
                  child: BlocBuilder<UltrasoundCubit, UltrasoundState>(
                    builder: (context, state) {
                      if (state.ultraSoundStatus == UltraSoundStatus.error) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: GlobalText(
                              textAlign: TextAlign.center,
                              text: 'Bu həftə üçün ultrasəs məlumatı tapılmadı',
                            ),
                          ),
                        );
                      } else if (state.ultraSoundStatus ==
                          UltraSoundStatus.networkError) {
                        return SvgPicture.asset('assets/svgs/forum_icon.svg');
                      } else if (state.ultraSoundStatus ==
                          UltraSoundStatus.loading) {
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: CircularProgressIndicator(),
                        ));
                      }
                      if (state.ultraSoundStatus == UltraSoundStatus.success) {
                        // final ultrasoundList = state.ultrasoundByWeek ?? [];
                        final ultrasoundByWeek = state.ultrasoundByWeek;
                        // for (var e in ultrasoundList) {
                        //   if (e.isActive!) {
                        //     ultrasoundByWeek = e;
                        //   }
                        // }

                        // Future.delayed(Duration(seconds: 1), () {
                        //   weekValue.value = 30;
                        // });
                        final format2d = ultrasoundByWeek?.image2D ?? '';
                        final format3d = ultrasoundByWeek?.image3D ?? '';
                        return Column(
                          children: [
                            24.h,
                            SelectableUltrasoundFormat(),
                            24.h,
                            BlocBuilder<MainCubit, MainInitial>(
                              buildWhen: (previous, current) {
                                return previous.ultrasoundFormat !=
                                    current.ultrasoundFormat;
                              },
                              builder: (context, state) {
                                final isTwoD = state.ultrasoundFormat ==
                                    UltrasoundFormat.format2d;
                                return CachedNetworkImage(
                                  imageUrl: isTwoD ? format2d : format3d,
                                  errorWidget: (context, url, error) {
                                    return Icon(Icons.image);
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
