import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../data/models/remote/response/indicator_model.dart';
import 'chart_data_not_found_widget.dart';

class PressureChartWidget extends StatelessWidget {
  const PressureChartWidget({
    super.key,
    required this.indicatorDataList,
  });

  final List<IndicatorModel> indicatorDataList;

// final List<BloodPressureData> data = [
//     BloodPressureData('de', 120, 80),
//     BloodPressureData('ddw', 130, 85),
//     BloodPressureData('dedwdw', 110, 70),
//     BloodPressureData('d', 140, 90),
//   ];
  @override
  Widget build(BuildContext context) {
    // final ValueNotifier<List<double>> errorValue =
    //     ValueNotifier<List<double>>([]);

    // for (var e in data) {
    //   errorValue.value.add((e.systolic - e.diastolic) / 2);
    // }

    return indicatorDataList.isEmpty
        ? ChartDataNotFoundWidget()
        : SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
              minimum: 60,
              maximum: 180,
              interval: 10,
              title: AxisTitle(text: 'Arterial Təzyiq (mmHg)'),
            ),
            series: <CartesianSeries>[
              ErrorBarSeries<IndicatorModel, String>(
                dataSource: indicatorDataList,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) {
                  final v1 = d.value ?? 120;
                  final v2 = d.value2 ?? 80;
                  final yValue = (v1 + v2) / 2;
                  return yValue;
                },
                verticalErrorValue: 10,
                color: Colors.teal.withOpacity(0.5),
                width: 2,
              ),
              ScatterSeries<IndicatorModel, String>(
                dataSource: indicatorDataList,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) => d.value ?? 120,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  width: 10,
                  height: 10,
                  shape: DataMarkerType.circle,
                  borderColor: Colors.teal,
                  borderWidth: 2,
                ),
                color: Colors.teal,
              ),
              ScatterSeries<IndicatorModel, String>(
                dataSource: indicatorDataList,
                xValueMapper: (d, _) => d.time,
                yValueMapper: (d, _) => d.value2 ?? 80,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  width: 10,
                  height: 10,
                  shape: DataMarkerType.circle,
                  borderColor: Colors.teal,
                  borderWidth: 2,
                ),
                color: Colors.teal,
              ),
            ],
          );
  }
}

// class BloodPressureData {
//   final String day;
//   final double systolic;
//   final double diastolic;
//   BloodPressureData(this.day, this.systolic, this.diastolic);
// }
