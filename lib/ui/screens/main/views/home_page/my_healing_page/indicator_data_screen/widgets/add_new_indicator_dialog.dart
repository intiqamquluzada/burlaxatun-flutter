import 'package:burla_xatun/cubits/indicator/indicator_cubit.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/my_healing_page/indicator_data_screen/widgets/date_or_time_box.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/my_healing_page/indicator_data_screen/widgets/pick_indicator_date_widget.dart';
import 'package:burla_xatun/utils/app/app_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';
import 'add_indicator_input.dart';

class AddNewIndicatorDialog extends StatefulWidget {
  const AddNewIndicatorDialog({
    super.key,
    required this.indicatorName,
  });

  final String indicatorName;

  @override
  State<AddNewIndicatorDialog> createState() => _AddNewIndicatorDialogState();
}

class _AddNewIndicatorDialogState extends State<AddNewIndicatorDialog> {
  late TextEditingController _indicatorController;
  @override
  void initState() {
    _indicatorController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<DateTime> dateValue = ValueNotifier(DateTime.now());
    final ValueNotifier<DateTime> timeValue = ValueNotifier(DateTime.now());
    final IndicatorCubit indicatorCubit = context.read<IndicatorCubit>();

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 480,
        child: Material(
          type: MaterialType.transparency,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22, right: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: SvgPicture.asset('assets/icons/close_icon.svg'),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
                GlobalText(
                  //text: 'New indicator',
                  text: 'Yeni göstərici',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                30.h,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    spacing: 20,
                    children: [
                      AddIndicatorInput(
                        inputName: 'Bədən çəkisi',
                        hintText: 'Kq',
                        controller: _indicatorController,
                      ),
                      ValueListenableBuilder(
                        valueListenable: dateValue,
                        builder: (context, value, child) {
                          final selectedDate =
                              DateFormat('yyyy-MM-dd').format(value);
                          return DateOrTimeBox(
                            inputName: 'Tarix',
                            hintText: selectedDate,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return PickIndicatorDateWidget(
                                    dateValue: dateValue,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: timeValue,
                        builder: (_, value, child) {
                          final hintTime = DateFormat('HH:mm').format(value);
                          return DateOrTimeBox(
                            hintText: hintTime,
                            inputName: 'Vaxt',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return PickIndicatorDateWidget(
                                    isTimeSelecting: true,
                                    timeValue: timeValue,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                20.h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 44,
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xffECECEC)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: GlobalText(
                          text: 'İmtina Et',
                          fontSize: 14,
                          height: 1.1,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(width: 22),
                    SizedBox(
                      height: 44,
                      width: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xffFFD3E2)),
                        ),
                        onPressed: () {
                          final selectedDate =
                              DateFormat('yyyy-MM-dd').format(dateValue.value);
                          final selectedTime =
                              DateFormat('HH:mm').format(timeValue.value);
                          indicatorCubit.addIndicator(
                            indicatorName: widget.indicatorName,
                            indicator: _indicatorController.text.trim(),
                            date: selectedDate,
                            time: selectedTime,
                          );
                        },
                        child: BlocConsumer<IndicatorCubit, IndicatorState>(
                          listener: (context, state) {
                            if (state.indicatorStatus ==
                                IndicatorStatus.error) {
                              context.pop();
                              AppSnackbars.error(context,
                                  'Göstərici əlavə edərkən xəta baş verdi');
                            } else if (state.indicatorStatus ==
                                IndicatorStatus.success) {
                              context.pop();
                              AppSnackbars.success(
                                  context, 'Göstərici uğurla əlavə olundu');
                            }
                          },
                          builder: (context, state) {
                            if (state.indicatorStatus ==
                                IndicatorStatus.loading) {
                              return CircularProgressIndicator.adaptive();
                            }
                            return GlobalText(
                              text: 'Yadda saxla',
                              fontSize: 14,
                              height: 1.1,
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.primaryRedColor,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
