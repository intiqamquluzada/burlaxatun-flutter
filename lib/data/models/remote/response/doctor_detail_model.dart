import 'package:equatable/equatable.dart';

class DoctorDetailResponse extends Equatable {
  final int? id;
  final Position? position;
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

  const DoctorDetailResponse({
    this.id,
    this.position,
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
  });

  factory DoctorDetailResponse.fromJson(Map<String, dynamic> json) =>
      DoctorDetailResponse(
        id: json["id"],
        position: json["position"] == null
            ? null
            : Position.fromJson(json["position"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "position": position?.toJson(),
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
        "available_times": availableTimes,
      };

  @override
  List<Object?> get props => [
        id,
        position,
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
