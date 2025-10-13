import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/doctors_list/doctors_cubit.dart';
import '../../../../../../../widgets/global_text.dart';
import 'doctor_box.dart';

class DoctorsListWidget extends StatefulWidget {
  const DoctorsListWidget({super.key});

  @override
  State<DoctorsListWidget> createState() => _DoctorsListWidgetState();
}

class _DoctorsListWidgetState extends State<DoctorsListWidget> {
  late ScrollController scrollController;
  late DoctorsCubit doctorsCubit;
  @override
  void initState() {
    scrollController = ScrollController();
    doctorsCubit = context.read<DoctorsCubit>();
    _loadMore();
    super.initState();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        doctorsCubit.getDoctorsList();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          BlocBuilder<DoctorsCubit, DoctorsState>(
            buildWhen: (previous, current) {
              return current.doctorStatus != DoctorsStatus.paginationLoading &&
                  previous.doctorStatus != current.doctorStatus;
            },
            builder: (context, state) {
              if (state.doctorStatus == DoctorsStatus.loading) {
                return Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              } else if (state.doctorStatus == DoctorsStatus.error) {
                return Center(
                  child: GlobalText(
                    text: 'Sahəyə uyğun həkim yüklənərkən xəta baş verdi',
                  ),
                );
              } else if (state.doctorStatus == DoctorsStatus.success) {
                final doctors = state.doctorList ?? [];
                return Visibility(
                  visible: doctors.isNotEmpty,
                  replacement: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: GlobalText(text: 'Sahəyə uyğun həkim yoxdur'),
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: ListView.separated(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: doctors.length,
                        itemBuilder: (_, i) {
                          final doctor = doctors[i];
                          return DoctorBox(doctor: doctor);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
          BlocSelector<DoctorsCubit, DoctorsState, DoctorsStatus>(
            selector: (state) {
              return state.doctorStatus;
            },
            builder: (context, status) {
              return Visibility(
                visible: status == DoctorsStatus.paginationLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
