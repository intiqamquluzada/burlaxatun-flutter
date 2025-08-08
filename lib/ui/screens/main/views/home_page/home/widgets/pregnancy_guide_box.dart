import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../../../cubits/select_task/select_task_cubit.dart';
import '../../../../../../../data/models/remote/response/tasks_by_week_model.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../widgets/global_text.dart';

class PregnancyGuideBox extends StatefulWidget {
  const PregnancyGuideBox({
    super.key,
    required this.task,
    required this.taskId,
    // required this.title,
    // required this.description,
  });

  final Task task;
  final int taskId;

  @override
  State<PregnancyGuideBox> createState() => _PregnancyGuideBoxState();
}

class _PregnancyGuideBoxState extends State<PregnancyGuideBox> {
  late SelectTaskCubit selectTaskCubit;
  late final ValueNotifier<bool> isCheckedGuideBoxNotifier;

  @override
  void initState() {
    selectTaskCubit = context.read<SelectTaskCubit>();
    isCheckedGuideBoxNotifier =
        ValueNotifier<bool>(widget.task.active ?? false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // isCheckedGuideBoxNotifier.value = !isCheckedGuideBoxNotifier.value;
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 21, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalText(
                    height: 1.3,
                    textAlign: TextAlign.left,
                    text: widget.task.name ?? 'Məlumat tapılmadı',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff484848),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.57,
                    child: Html(data: widget.task.text ?? 'Məlumat tapılmadı'),
                  ),
                  // SizedBox(
                  //   width: 226,
                  //   child: GlobalText(
                  //     height: 1.3,
                  //     textAlign: TextAlign.left,
                  //     text: description,
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: Color(0xff484848),
                  //   ),
                  // ),
                ],
              ),
              BlocListener<SelectTaskCubit, SelectTaskState>(
                listenWhen: (previous, current) {
                  return previous.selectTaskStatus != current.selectTaskStatus;
                },
                listener: (context, state) {
                  if (state.selectTaskStatus == SelectTaskStatus.success) {
                    log('success');
                  } else if (state.selectTaskStatus == SelectTaskStatus.error) {
                    AppSnackbars.error(
                      context,
                      'Tapşırığı seçərkən xəta baş verdi',
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ValueListenableBuilder(
                    valueListenable: isCheckedGuideBoxNotifier,
                    builder: (context, value, child) {
                      log('builded checkbox');
                      return Checkbox(
                        side: BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                        visualDensity: VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        splashRadius: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: ColorConstants.primaryRedColor,
                        value: value,
                        onChanged: (v) async {
                          isCheckedGuideBoxNotifier.value = v!;
                          final isSuccess = await selectTaskCubit.selectTask(
                            isSelected: v,
                            taskId: widget.task.id ?? -1,
                          );
                          !isSuccess
                              ? isCheckedGuideBoxNotifier.value =
                                  !isCheckedGuideBoxNotifier.value
                              : null;
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // ValueListenableBuilder(
    //   valueListenable: isCheckedGuideBoxNotifier,
    //   builder: (context, value, child) {
    //     log('box builded');

    //   },
    // );
  }
}
