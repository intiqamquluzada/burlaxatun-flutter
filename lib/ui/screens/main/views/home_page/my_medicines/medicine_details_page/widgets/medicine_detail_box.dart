import 'package:burla_xatun/data/models/remote/response/medicine/medicines_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../cubits/main_cubit/mainn_cubit.dart';
import 'medicine_detail_tile.dart';

class MedicineDetailBox extends StatelessWidget {
  final Result data;

  const MedicineDetailBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return SizedBox(
      height: 414,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xffF7F7F7),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 36.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 6; i++)
                MedicineDetailTile(
                  detailName: mainCubit.medicineDetailItems[i].detailName,
                  detail: _getDetail(i, data),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDetail(int index, Result data) {
    switch (index) {
      case 0:
        return data.name ?? 'Ad yoxdur';
      case 1:
        return "${data.dose} mg";
      case 2:
        return data.frequency ?? 'Tezlik yoxdur';
      case 3:
        return _formatDate(data.startDate);
      case 4:
        return _formatDate(data.endDate);
      case 5:
        return data.status ?? 'Status yoxdur';
      default:
        return 'N/A';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Tarix yoxdur';
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
