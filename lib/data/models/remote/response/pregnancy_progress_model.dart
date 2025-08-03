
class PregnancyProgressModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<ProgressData>? results;

  PregnancyProgressModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory PregnancyProgressModel.fromJson(Map<String, dynamic> json) =>
      PregnancyProgressModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<ProgressData>.from(
                json["results"]!.map((x) => ProgressData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ProgressData {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? week;
  final String? name;
  final String? subTitle;
  final String? text;
  final String? imageLeft;
  final String? imageRight;

  ProgressData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.week,
    this.name,
    this.subTitle,
    this.text,
    this.imageLeft,
    this.imageRight,
  });

  factory ProgressData.fromJson(Map<String, dynamic> json) => ProgressData(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        week: json["week"],
        name: json["name"],
        subTitle: json["sub_title"],
        text: json["text"],
        imageLeft: json["image_left"],
        imageRight: json["image_right"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "week": week,
        "name": name,
        "sub_title": subTitle,
        "text": text,
        "image_left": imageLeft,
        "image_right": imageRight,
      };
}
