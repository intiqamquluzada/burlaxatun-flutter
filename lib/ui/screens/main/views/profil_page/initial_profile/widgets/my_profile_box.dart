import 'package:burla_xatun/cubits/user_data/user_data_cubit.dart';
import 'package:burla_xatun/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_text.dart';

class MyProfileBox extends StatelessWidget {
  const MyProfileBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          child: BlocBuilder<UserDataCubit, UserDataState>(
            builder: (_, state) {
              if (state.status == UserDataStatus.loading) {
                return Center(
                  child: CustomCircularProgressIndicator(),
                );
              }
              if (state.status == UserDataStatus.failure) {
                return Center(
                  child: Text('Xəta'),
                );
              }
              if (state.status == UserDataStatus.networkError) {
                return Center(
                  child: Text('Şəbəkə xətası'),
                );
              }
              if (state.status == UserDataStatus.success) {
                final data = state.response;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: 'Hesabım',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    32.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Ad və Soyadınız',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        GlobalText(
                          text: data?.fullName ?? 'Ad',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Yaşınız',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        GlobalText(
                          text: data?.birthday != null
                              ? DateFormat('yyyy-MM-dd').format(data!.birthday!)
                              : 'Bilinmir',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                      ],
                    ),
                    14.h,
                    ColoredBox(
                      color: Color(0xffF2F4F7),
                      child: SizedBox(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    14.h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalText(
                          text: 'Siz kimsiniz?',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                        GlobalText(
                          text: 'Ana',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344054),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
