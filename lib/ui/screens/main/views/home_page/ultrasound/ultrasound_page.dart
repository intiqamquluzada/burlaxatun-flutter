import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../cubits/main_cubit/main_state.dart';
import '../../../../../../cubits/main_cubit/mainn_cubit.dart';
import '../../../../../../cubits/ultrasound/ultrasound_cubit.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import '../widgets/scrollable_days_appbar.dart';
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
    ultrasoundCubit = context.read<UltrasoundCubit>()..getUltraSound();
    weekValue = ValueNotifier<int?>(1);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log('reached end of bar');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(175),
        child: ScrollableDaysAppbar(
          appbarName: 'Ultrasəs',
          weekValue: weekValue,
          scrollController: scrollController,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: BlocBuilder<UltrasoundCubit, UltrasoundState>(
              builder: (context, state) {
                if (state.ultraSoundStatus == UltraSoundStatus.error) {
                  return Text('Məlumat tapılmadı');
                } else if (state.ultraSoundStatus ==
                    UltraSoundStatus.networkError) {
                  return SvgPicture.asset('assets/svgs/forum_icon.svg');
                } else if (state.ultraSoundStatus == UltraSoundStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.ultraSoundStatus == UltraSoundStatus.success) {
                  final ultrasoundList = state.ultrasound?.results ?? [];
                  final ultrasoundByWeek =
                      ultrasoundList.isEmpty ? null : ultrasoundList.first;

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
          ),
        ),
      ),
    );
  }
}
