import 'package:burla_xatun/data/models/remote/response/medicine/medicines_model.dart';
import 'package:burla_xatun/ui/screens/main/views/home_page/my_medicines/medicine_details_page/widgets/edit_details_button.dart';
import 'package:burla_xatun/utils/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../widgets/global_appbar.dart';
import 'widgets/medicine_detail_box.dart';

class MedicineDetailsPage extends StatefulWidget {
  final Result data;

  const MedicineDetailsPage({super.key, required this.data});

  @override
  State<MedicineDetailsPage> createState() => _MedicineDetailsPageState();
}

class _MedicineDetailsPageState extends State<MedicineDetailsPage> {
  late Result _currentData;

  @override
  void initState() {
    super.initState();
    _currentData = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppbar(
        title: 'Dərmanlarım',
        onLeadingTap: () => context.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20) +
            const EdgeInsets.only(top: 33),
        child: Column(
          children: [
            MedicineDetailBox(data: _currentData),
            31.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EditDetailsButton(
                  data: _currentData,
                  onUpdated: (updatedData) {
                    setState(() {
                      _currentData = updatedData;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
