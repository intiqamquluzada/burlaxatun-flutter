import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../cubits/doctor_notification/doctor_notification_cubit.dart';
import '../../../../../../../../utils/di/locator.dart';
import '../../../../../../../widgets/global_input.dart';
import 'doctors_notification.dart';

class SearchAndNotification extends StatelessWidget {
  final void Function(String)? onSearch;

  const SearchAndNotification({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    // final mainCubit = context.read<MainCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.82,
              child: GlobalInput(
                prefixIcon: 'assets/icons/search_icon.svg',
                hintText: 'Axtarış...',
                onChanged: onSearch,
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  isScrollControlled: true, 
                  context: context,
                  builder: (_) {
                    return BlocProvider(
                      create: (context) => locator<DoctorNotificationCubit>()..getDrNotifications(),
                      child: DoctorsNotification(),
                    );
                  },
                );
              },
              child: SvgPicture.asset('assets/icons/notification_bing.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
