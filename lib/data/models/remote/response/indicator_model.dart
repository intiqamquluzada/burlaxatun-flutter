class IndicatorModel {
  final String? time;
  final double? value;
  final double? value2;

  IndicatorModel({
    this.time,
    this.value,
    this.value2,
  });

  factory IndicatorModel.fromJson(Map<String, dynamic> json) => IndicatorModel(
        time: json["time"],
        value: json["value"]?.toDouble(),
        value2: json["value2"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "value": value,
      };
}
