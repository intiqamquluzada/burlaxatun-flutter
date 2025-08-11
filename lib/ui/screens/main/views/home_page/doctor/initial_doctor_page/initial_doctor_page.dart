import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../cubits/doctors_list/doctors_list_cubit.dart';
import '../../../../../../../data/models/remote/response/doctors_list_model.dart';
import '../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../widgets/global_appbar.dart';
import 'widgets/doctor_box.dart';
import 'widgets/doctor_categories.dart';
import 'widgets/search_and_notification.dart';

class InitialDoctorPage extends StatefulWidget {
  const InitialDoctorPage({super.key});

  @override
  State<InitialDoctorPage> createState() => _InitialDoctorPageState();
}

class _InitialDoctorPageState extends State<InitialDoctorPage> {
  Position? selectedPosition;
  String searchQuery = '';
  // late DoctorsListCubit doctorsListCubit;

  @override
  void initState() {
    // doctorsListCubit = context.read<DoctorsListCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFCFD),
      appBar: GlobalAppbar(
        title: 'Həkimlər',
        onLeadingTap: () => context.pop(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<DoctorsListCubit, DoctorsListState>(
            builder: (_, state) {
              if (state.status == DoctorsListStatus.loading) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator.adaptive(),
                  ],
                );
              } else if (state.status == DoctorsListStatus.failure ||
                  state.status == DoctorsListStatus.networkError) {
                log('Doctor list error: ${state.errorMessage}');
                return Text(
                  state.status == DoctorsListStatus.failure
                      ? 'Error'
                      : 'Network Error',
                );
              } else if (state.status == DoctorsListStatus.success) {
                final doctors = state.response?.results ?? [];

                final positions = {for (var doc in doctors) doc.position}
                    .whereType<Position>()
                    .toList();

                /// Fetched datas that screen loaded for first time
                if (selectedPosition == null && positions.isNotEmpty) {
                  selectedPosition = positions[0];
                }

                final filteredDoctors = doctors.where((doc) {
                  final matchesPosition = selectedPosition == null ||
                      doc.position?.id == selectedPosition?.id;

                  final lowerQuery = searchQuery.toLowerCase();
                  final matchesSearch = doc.name
                              ?.toLowerCase()
                              .contains(lowerQuery) ==
                          true ||
                      doc.surname?.toLowerCase().contains(lowerQuery) == true ||
                      doc.workplace?.toLowerCase().contains(lowerQuery) ==
                          true ||
                      doc.position?.name?.toLowerCase().contains(lowerQuery) ==
                          true;

                  return matchesPosition && matchesSearch;
                }).toList();

                return Column(
                  children: [
                    SearchAndNotification(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    24.h,
                    DoctorCategories(
                      positions: positions,
                      selected: selectedPosition,
                      onSelect: (position) {
                        setState(() {
                          selectedPosition = position;
                        });
                      },
                    ),
                    16.h, 
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 13),
                      child: Column(
                        children: filteredDoctors
                            .map((doctor) => DoctorBox(doctor: doctor))
                            .toList(),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
