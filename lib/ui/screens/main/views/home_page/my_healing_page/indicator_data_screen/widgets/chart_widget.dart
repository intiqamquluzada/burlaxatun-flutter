import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../data/models/remote/response/indicator_model.dart';
import 'chart_data_not_found_widget.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.indicatorDataList,
  });

  final List<IndicatorModel> indicatorDataList;

  @override
  Widget build(BuildContext context) {
    return indicatorDataList.isEmpty
        ? ChartDataNotFoundWidget()
        : SfCartesianChart(
            // primaryYAxis: NumericAxis(),
            primaryXAxis: CategoryAxis(
              maximumLabels: indicatorDataList.length,
              // minimum: 0,
              maximum: indicatorDataList.length.toDouble(),
              labelPlacement: LabelPlacement.onTicks,
              // axisLabelFormatter: (AxisLabelRenderDetails details) {
              //   if (details.text == 'True 03' ||
              //       details.text == '03 AM' ||
              //       details.text == '06 AM' ||
              //       details.text == '09 AM' ||
              //       details.text == '12 AM') {
              //     return ChartAxisLabel(details.text, TextStyle());
              //   }
              //   return ChartAxisLabel('', TextStyle());
              // },
            ),
            series: [
              LineSeries(
                dataSource: indicatorDataList,
                xValueMapper: (data, _) => data.time,
                yValueMapper: (data, _) => data.value,
                markerSettings: MarkerSettings(
                  height: 12,
                  width: 12,
                  isVisible: true,
                  color: Color(0xff1A5499),
                  shape: DataMarkerType.circle,
                ),
                color: Color(0xffAFF2F2),
                width: 2,
                animationDuration: 150,
              ),
            ],
          );
  }
}
