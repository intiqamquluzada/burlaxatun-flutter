import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../cubits/tasks_by_weeks/tasks_by_weeks_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';
import 'pregnancy_guide_box.dart';

class PregnancyGuide extends StatefulWidget {
  const PregnancyGuide({
    super.key,
    this.pregnantWeek,
  });

  final String? pregnantWeek;

  @override
  State<PregnancyGuide> createState() => _PregnancyGuideState();
}

class _PregnancyGuideState extends State<PregnancyGuide> {
  late TasksByWeeksCubit tasksByWeeksCubit;

  @override
  void initState() {
    tasksByWeeksCubit = context.read<TasksByWeeksCubit>()..getTasksByWeek();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksByWeeksCubit, TasksByWeeksState>(
      builder: (context, state) {
        log('STATUS: ${state.tasksByWeekStatus}');
        if (state.tasksByWeekStatus == TasksByWeekStatus.loading) {
          return Center(child: CircularProgressIndicator.adaptive());
        } else if (state.tasksByWeekStatus == TasksByWeekStatus.error) {
          return Center(child: Text('Məlumat tapılmadı'));
        } else if (state.tasksByWeekStatus == TasksByWeekStatus.networkError) {
          return Center(child: Text(state.networkErrorMessage!));
        }
        if (state.tasksByWeekStatus == TasksByWeekStatus.success) {
          final tasks = state.tasksByWeek ?? [];
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ), 
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 26),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalText(
                          textAlign: TextAlign.end,
                          text:
                              'Hamiləlik Bələdçisi · ${widget.pregnantWeek ?? '0'}. Həftə',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff8C8A8A),
                        ),
                      ],
                    ),
                    13.h,
                    tasks.isEmpty
                        ? Text('Bu həftə üçün hələlik tapşırıq əlavə edilməyib')
                        : Column(
                            spacing: 24,
                            children: [
                              for (int i = 0; i < tasks.length; i++)
                                PregnancyGuideBox(
                                  task: tasks[i],
                                  taskId: tasks[i].id ?? -1,
                                ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox.fromSize();
      },
    );
  }
}
