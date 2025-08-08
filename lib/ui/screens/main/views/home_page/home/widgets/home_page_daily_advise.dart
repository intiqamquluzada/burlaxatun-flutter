import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/daily_rec/daily_rec_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class HomePageDailyAdvise extends StatefulWidget {
  const HomePageDailyAdvise({super.key});

  @override
  State<HomePageDailyAdvise> createState() => _HomePageDailyAdviseState();
}

class _HomePageDailyAdviseState extends State<HomePageDailyAdvise> {
  late DailyRecCubit dailyRecCubit;
  @override
  void initState() {
    // dailyRecCubit = context.read<DailyRecCubit>()..getDailyRec();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: BlocBuilder<DailyRecCubit, DailyRecState>(
        builder: (_, state) {
          if (state.status == DailyRecStatus.loading) {
            return CircularProgressIndicator.adaptive();
          }

          if (state.status == DailyRecStatus.failure) {
            return const Center(child: Text('Xəta'));
          }

          if (state.status == DailyRecStatus.networkError) {
            return const Center(child: Text('Şəbəkə xətası'));
          }

          if (state.status == DailyRecStatus.success) {
            final recommendation = state.myRecommendation;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  26.h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GlobalText(
                        textAlign: TextAlign.left,
                        text:
                            'Gündəlik Tövsiyyələr · ${recommendation?.day}. Gün',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff8C8A8A),
                      ),
                    ],
                  ),
                  17.h,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: CachedNetworkImage(
                      imageUrl: recommendation?.image ??
                          'assets/images/default_image.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 116,
                      placeholder: (context, url) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.broken_image, size: 100);
                      },
                    ),
                  ),
                  16.h,
                  Align(
                    alignment: Alignment.topLeft,
                    child: GlobalText(
                      textAlign: TextAlign.left,
                      text: recommendation?.name ?? '',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  11.h,
                  GlobalText(
                    height: 1.3,
                    maxLines: 8,
                    textAlign: TextAlign.left,
                    text: recommendation?.text ?? '',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff969BAB),
                  ),
                  16.h,
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
