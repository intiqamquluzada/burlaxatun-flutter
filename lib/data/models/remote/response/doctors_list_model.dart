import 'package:equatable/equatable.dart';

class DoctorsListResponse extends Equatable {
  final int? count;
  final String? next;
  final String? previous;
  final List<Result>? results;

  const DoctorsListResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DoctorsListResponse.fromJson(Map<String, dynamic> json) =>
      DoctorsListResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
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

class Result extends Equatable {
  final int? id;
  final Profession? profession;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? email;
  final String? name;
  final String? surname;
  final String? image;
  final String? workplace;
  final double? consultantPrice;
  final String? availableDays;
  final String? availableTimes;
  final Position? position; // Updated type from int? to Position

  const Result({
    this.id,
    this.profession,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.email,
    this.name,
    this.surname,
    this.image,
    this.workplace,
    this.consultantPrice,
    this.availableDays,
    this.availableTimes,
    this.position,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        profession: json["profession"] == null
            ? null
            : Profession.fromJson(json["profession"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
        image: json["image"],
        workplace: json["workplace"],
        consultantPrice: json["consultant_price"],
        availableDays: json["available_days"],
        availableTimes: json["available_times"],
        position: json["position"] == null
            ? null
            : Position.fromJson(
                json["position"],
              ), // Deserialize position as a Position object
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profession": profession?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "email": email,
        "name": name,
        "surname": surname,
        "image": image,
        "workplace": workplace,
        "consultant_price": consultantPrice,
        "available_days": availableDays,
        "available_time": availableTimes,
        "position": position?.toJson(), // Serialize position back to JSON
      };

  @override
  List<Object?> get props => [
        id,
        profession,
        createdAt,
        updatedAt,
        slug,
        email,
        name,
        surname,
        image,
        workplace,
        consultantPrice,
        availableDays,
        availableTimes,
        position,
      ];
}

class Profession extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;

  const Profession({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        name,
      ];
}

class Position extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;

  const Position({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        name,
      ];
}
