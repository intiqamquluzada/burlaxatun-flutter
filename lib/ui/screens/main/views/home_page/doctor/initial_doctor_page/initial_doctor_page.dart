import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/doctors_list/doctors_cubit.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import 'widgets/doctor_categories.dart';
import 'widgets/doctors_list_widget.dart';
import 'widgets/search_and_notification.dart';

class InitialDoctorPage extends StatefulWidget {
  const InitialDoctorPage({super.key});

  @override
  State<InitialDoctorPage> createState() => _InitialDoctorPageState();
}

class _InitialDoctorPageState extends State<InitialDoctorPage> {
  late DoctorsCubit doctorsListCubit;
  Timer? _debounce;

  @override
  void initState() {
    doctorsListCubit = context.read<DoctorsCubit>();
    _getInitialData();
    super.initState();
  }

  Future<void> _getInitialData() async {
    await doctorsListCubit.getSpecializations().then((v) async {
      await doctorsListCubit.getDoctorsList(
        specializationId: doctorsListCubit.state.specializationList?.first.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFCFD),
      appBar: GlobalAppbar(
        title: 'Həkimlər',
        onLeadingTap: () => context.pop(),
      ),
      body: BlocBuilder<DoctorsCubit, DoctorsState>(
        buildWhen: (previous, current) {
          return previous.specializationList == null ||
              previous.doctorList == null;
        },
        builder: (context, state) {
          if (state.doctorStatus == DoctorsStatus.loading ||
              state.specializationStatus == SpecializatonsStatus.loading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state.doctorStatus == DoctorsStatus.error &&
              state.specializationStatus == SpecializatonsStatus.error) {
            return Center(
              child: Text('Məlumatlar yüklənərkən xəta baş verdi'),
            );
          } else if (state.doctorStatus == DoctorsStatus.success ||
              state.specializationStatus == SpecializatonsStatus.success) {
            return Column(
              children: [
                SearchAndNotification(
                  onSearch: (query) async {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(
                      const Duration(milliseconds: 500),
                      () async {
                        await doctorsListCubit.getDoctorsList(
                          specializationId:
                              doctorsListCubit.state.specializationId,
                          search: query, 
                        );
                      },
                    );
                  },
                ),
                24.h,
                DoctorCategories(),
                16.h,
                DoctorsListWidget(),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
