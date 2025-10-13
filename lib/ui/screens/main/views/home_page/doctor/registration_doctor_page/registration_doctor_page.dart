import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/doctor_reservation/doctor_reservation_cubit.dart';
import '../../../../../../../cubits/doctors_detail/doctors_detail_cubit.dart';
import '../../../../../../../utils/app/app_snackbars.dart';
import '../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_button.dart';
import '../../../../../add_child/widgets/add_child_success_dialog.dart';
import 'widgets/registration_date_and_time_widget.dart';
import 'widgets/registration_doctor_info.dart';
import 'widgets/registration_price_and_time.dart';

class RegistrationDoctorPage extends StatelessWidget {
  const RegistrationDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorReservationCubit doctorReservationCubit =
        context.read<DoctorReservationCubit>();
    return Scaffold(
      // backgroundColor: Color(0xffFCFCFD),
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: SafeArea(
          child: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff344054),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                BlocBuilder<DoctorDetailCubit, DoctorDetailState>(
                  buildWhen: (previous, current) {
                    return previous.doctorDetailStatus !=
                        current.doctorDetailStatus;
                  },
                  builder: (context, state) {
                    if (state.doctorDetailStatus ==
                        DoctorDetailStatus.loading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.doctorDetailStatus ==
                            DoctorDetailStatus.failure ||
                        state.doctorDetailStatus ==
                            DoctorDetailStatus.networkError) {
                      return Center(
                        child: Text(
                          'Həkim məlumatlarını yüklərkən xəta baş verdi',
                        ),
                      );
                    } else if (state.doctorDetailStatus ==
                        DoctorDetailStatus.success) {
                      final doctor = state.doctorDetails;

                      if (doctor == null) {
                        return Center(child: Text('Həkim məlumatı tapılmadı.'));
                      }

                      return Column(
                        children: [
                          RegistrationDoctorInfo(doctor: doctor),
                          32.h,
                          RegistrationPriceAndTime(doctor: doctor),
                          40.h,
                          RegistrationDateAndTimeWidget(),
                          75.h,
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<DoctorReservationCubit, DoctorReservationState>(
          buildWhen: (previous, current) {
            return previous.doctorReservStatus != current.doctorReservStatus;
          },
          listenWhen: (previous, current) {
            return previous.doctorReservStatus != current.doctorReservStatus;
          },
          listener: (context, state) {
            if (state.doctorReservStatus == DoctorReservStatus.error) {
              AppSnackbars.error(
                  context, state.errorMessage ?? 'Xəta baş verdi');
            } else if (state.doctorReservStatus == DoctorReservStatus.success) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  return AddChildSuccessDialog(
                    text: 'Qeydiyyat təsdiqlənmişdir',
                  );
                },
              );
              //  context.go('/home');
            }
          },
          builder: (context, state) {
            return GlobalButton(
              isLoading: state.doctorReservStatus == DoctorReservStatus.loading,
              buttonName: 'Qeydiyyat',
              buttonColor: ColorConstants.primaryRedColor,
              textColor: Colors.white,
              onPressed: () {
                doctorReservationCubit.reservDoctor();
              },
            );
          },
        ),
      ),
    );
  }
}
