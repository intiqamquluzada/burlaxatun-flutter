import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/doctor_notification/doctor_notification_cubit.dart';
import '../../../../../../../../cubits/doctor_notification/doctor_notification_state.dart';
import '../../../../../../../../utils/extensions/context_extensions.dart';
import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';
import 'doctors_notification_box_widget.dart';

class DoctorsNotification extends StatefulWidget {
  const DoctorsNotification({super.key});

  @override
  State<DoctorsNotification> createState() => _DoctorsNotificationState();
}

class _DoctorsNotificationState extends State<DoctorsNotification> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.deviceHeight * 0.6,
      child: Padding(
        padding: const EdgeInsets.only(left: 17, right: 11),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GlobalText(
                  text: 'Bildirişlər',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
            24.h,
            BlocBuilder<DoctorNotificationCubit, DoctorNotificationState>(
              builder: (context, state) {
                if (state.drNotificationStatus == DrNotificationStatus.error) {
                  return Text('Xəta');
                } else if (state.drNotificationStatus ==
                    DrNotificationStatus.loading) {
                  return CircularProgressIndicator.adaptive();
                }
                if (state.drNotificationStatus ==
                    DrNotificationStatus.success) {
                  final reservations = state.myReservations ?? [];
                  return reservations.isEmpty
                      ? Text('Reservasiya yoxdur')
                      : Expanded(
                          child: ListView.builder(
                            itemCount: reservations.length,
                            itemBuilder: (_, i) {
                              return DoctorsNotificationBoxWidget(
                                reservation: reservations[i],
                              );
                            },
                          ),
                        );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
