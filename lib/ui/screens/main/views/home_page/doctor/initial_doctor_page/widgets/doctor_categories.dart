import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/doctors_list/doctors_cubit.dart';
import 'category_box.dart';

class DoctorCategories extends StatefulWidget {
  const DoctorCategories({super.key});

  @override
  State<DoctorCategories> createState() => _DoctorCategoriesState();
}

class _DoctorCategoriesState extends State<DoctorCategories>
    with AutomaticKeepAliveClientMixin {
  late ValueNotifier<int> selectedSpecialization;
  late DoctorsCubit doctorsCubit;
  late ScrollController scrollController;

  @override
  void initState() {
    doctorsCubit = context.read<DoctorsCubit>();
    scrollController = ScrollController();
    selectedSpecialization = ValueNotifier<int>(
        doctorsCubit.state.specializationList?.first.id ?? 0);
    _loadMore();
    super.initState();
  }

  void _loadMore() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        doctorsCubit.getSpecializations();
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
    super.build(context);
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      buildWhen: (previous, current) {
        return previous.specializationList != current.specializationList;
      },
      builder: (context, state) {
        if (state.specializationStatus == SpecializatonsStatus.success) {
          final specializatons = state.specializationList;

          return SizedBox(
            height: 40,
            child: ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: state.specializationList?.length ?? 0,
              itemBuilder: (_, i) {
                final specializaton = specializatons?[i];
                return Row(
                  children: [
                    if (i == 0) const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () async {
                        selectedSpecialization.value = specializaton?.id ?? 0;
                        await doctorsCubit.getDoctorsList(
                          specializationId: specializaton?.id,
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: selectedSpecialization,
                        builder: (BuildContext context, value, Widget? child) {
                          return CategoryBox(
                            doctorCategory:
                                specializaton?.name ?? 'sahə tapılmadı',
                            isSelected: specializaton?.id == value,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 10),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
