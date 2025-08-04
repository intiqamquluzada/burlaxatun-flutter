// class TasksByWeekModel {
//   final String? week;
//   final List<Task>? tasks;

//   TasksByWeekModel({
//     this.week,
//     this.tasks,
//   });

//   factory TasksByWeekModel.fromJson(Map<String, dynamic> json) =>
//       TasksByWeekModel(
//         week: json["week"],
//         tasks: json["tasks"] == null
//             ? []
//             : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "week": week,
//         "tasks": tasks == null
//             ? []
//             : List<dynamic>.from(tasks!.map((x) => x.toJson())),
//       };
// }

class Task {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? week;
  final String? name;
  final String? text;

  Task({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.week,
    this.name,
    this.text,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        week: json["week"],
        name: json["name"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "week": week,
        "name": name,
        "text": text,
      };
}
