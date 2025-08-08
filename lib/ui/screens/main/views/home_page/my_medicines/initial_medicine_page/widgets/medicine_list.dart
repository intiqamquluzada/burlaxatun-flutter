import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/medicine/medicine_cubit.dart';
import '../../../../../../../../utils/constants/color_constants.dart';
import '../../../../../../../../utils/extensions/num_extensions.dart';
import '../../../../../../../widgets/global_text.dart';
import 'single_medicine_tile.dart';

class MedicineList extends StatelessWidget {
  const MedicineList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.84,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<MedicineCubit, MedicineState>(
        builder: (_, state) {
          if (state.status == MedicineStatus.loading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state.status == MedicineStatus.failure) {
            return const Center(child: Text('Xəta'));
          }
          if (state.status == MedicineStatus.networkError) {
            return const Center(child: Text('Şəbəkə xətası'));
          }

          if (state.status == MedicineStatus.success) {
            final results = state.response?.results ?? [];

            return RefreshIndicator(
              color: ColorConstants.primaryRedColor,
              onRefresh: () async {
                context.read<MedicineCubit>().getMedicines();
              },
              child: results.isEmpty
                  ? ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: GlobalText(
                              text: 'Dərman yoxdur',
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: results.length,
                      itemBuilder: (_, i) {
                        return Center(
                          child: Column(
                            children: [
                              SingleMedicineTile(data: results[i]),
                              10.h,
                            ],
                          ),
                        );
                      },
                    ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
