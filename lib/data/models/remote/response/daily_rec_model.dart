import 'package:equatable/equatable.dart';

class DailyRecResponse extends Equatable {
  final int? count;
  final String? next;
  final String? previous;
  final List<Recommendation>? results;

  const DailyRecResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DailyRecResponse.fromJson(Map<String, dynamic> json) =>
      DailyRecResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Recommendation>.from(
                json["results"]!.map((x) => Recommendation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}

class Recommendation extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? active;
  final String? slug;
  final int? day;
  final String? name;
  final String? text;
  final String? image;

  const Recommendation({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.active,
    this.slug,
    this.day,
    this.name,
    this.text,
    this.image,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) => Recommendation(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        active: json["active"],
        day: json["day"],
        name: json["name"],
        text: json["text"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "day": day,
        "name": name,
        "text": text,
        "image": image,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        slug,
        active,
        day,
        name,
        text,
        image,
      ];
}
