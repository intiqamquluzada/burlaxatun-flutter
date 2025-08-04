import 'package:burla_xatun/ui/screens/main/views/daily_advise_page/advice_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/daily_rec/daily_rec_cubit.dart';
import '../../../../../cubits/daily_rec_detail/daily_rec_detail_cubit.dart';
import '../../../../widgets/custom_circular_progress_indicator.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

class _AdvicePageState extends State<AdvicePage> {
  String? _slug;
  bool _detailFetched = false;

  @override
  void initState() {
    super.initState();
    context.read<DailyRecCubit>().getDailyRec();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyRecCubit, DailyRecState>(
      builder: (_, dailyRecState) {
        if (dailyRecState.status == DailyRecStatus.loading) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        } else if (dailyRecState.status == DailyRecStatus.failure) {
          return const Center(
            child: Text('Xəta'),
          );
        } else if (dailyRecState.status == DailyRecStatus.networkError) {
          return const Center(
            child: Text('Şəbəkə xətası'),
          );
        } else if (dailyRecState.status == DailyRecStatus.success) {
          // Create a slug one time
          // _slug ??= dailyRecState.response?.results?.first.slug;

          if (_slug == null) {
            return const Center(
              child: Text("Slug not found"),
            );
          }

          // Fetch detail for only one time
          if (!_detailFetched) {
            _detailFetched = true;
            context.read<DailyRecDetailCubit>().getDailyRecDetail(_slug!);
          }

          return AdviceDetailView();
        }

        return const SizedBox.shrink();
      },
    );
  }
}
