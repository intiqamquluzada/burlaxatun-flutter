class AddIndicatorRequestModel {
  final int? babyId;
  final String? name;
  final String? indicator;
  final String? indicator2;
  final String? date;
  final String? time;

  AddIndicatorRequestModel({
    this.babyId,
    this.name,
    this.indicator,
    this.indicator2,
    this.date,
    this.time,
  });

  factory AddIndicatorRequestModel.fromJson(Map<String, dynamic> json) =>
      AddIndicatorRequestModel(
        babyId: json["baby_id"],
        name: json["name"],
        indicator: json["indicator"],
        indicator2: json["indicator2"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() {
    return {
      "baby_id": babyId,
      "name": name,
      "indicator": indicator,
      "indicator2":
          indicator2 == null || indicator2!.isEmpty ? null : indicator2,
      "date": date,
      "time": time,
    };
  }
}

// class AddIndicatorRequestModel {
//   final int? babyId;
//   final String? name;
//   final String? indicator;
//   final String? date;
//   final String? time;

//   AddIndicatorRequestModel({
//     this.babyId,
//     this.name,
//     this.indicator,
//     this.date,
//     this.time,
//   });

//   factory AddIndicatorRequestModel.fromJson(Map<String, dynamic> json) =>
//       AddIndicatorRequestModel(
//         babyId: json["baby_id"],
//         name: json["name"],
//         indicator: json["indicator"],
//         date: json["date"],
//         time: json["time"],
//       );

//   Map<String, dynamic> toJson() => {
//         "baby_id": babyId,
//         "name": name,
//         "indicator": indicator,
//         "date": date,
//         "time": time,
//       };
// }
