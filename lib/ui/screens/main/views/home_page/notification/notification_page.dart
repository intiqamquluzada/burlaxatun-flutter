import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../cubits/notification/notification_cubit.dart';
import '../../../../../../utils/extensions/num_extensions.dart';
import 'widgets/last_days.dart';
import 'widgets/notification_appbar.dart';
import 'widgets/notification_box.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    notificationCubit = context.read<NotificationCubit>();
    notificationCubit.getNofitications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      appBar: NotificationAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state.notificationStatus == NotificationStatus.error) {
              return Center(child: Text('Məlumat tapılmadı'));
            } else if (state.notificationStatus == NotificationStatus.loading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.notificationStatus == NotificationStatus.success) {
              final notificationList = state.notifications ?? [];
              return notificationList.isEmpty
                  ? Center(child: Text('Bildiriş yoxdur'))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        28.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            LastDays(
                              createdAt:
                                  notificationList.last.createdAt.toString(),
                            )
                          ],
                        ),
                        24.h,
                        Expanded(
                          child: ListView.separated(
                            itemCount: notificationList.length,
                            itemBuilder: (_, i) {
                              return NotificationBox(
                                notification: notificationList[i],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return 23.h;
                            },
                          ),
                        ),
                      ],
                    );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
