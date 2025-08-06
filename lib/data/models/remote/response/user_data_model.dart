import 'package:equatable/equatable.dart';

class UserDataResponse extends Equatable {
  final int? id;
  final String? email;
  final String? fullName;
  final String? phoneNumber;
  final DateTime? birthday;
  final bool? onboardingDone;
  final bool? wantToBePregnant;
  final bool? wantToSeePeriod;
  final bool? isPregnant;
  final bool? haveMiscarriage;
  final String? pregnantWeek;
  final bool? firstChild;
  final String? relation;
  final String? image;
  final String? activeLanguage;
  final bool? enableNotifications;
  final List<Baby>? babies;

  const UserDataResponse({
    this.id,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.birthday,
    this.onboardingDone,
    this.wantToBePregnant,
    this.haveMiscarriage,
    this.wantToSeePeriod,
    this.isPregnant,
    this.pregnantWeek,
    this.firstChild,
    this.relation,
    this.image,
    this.activeLanguage,
    this.enableNotifications,
    this.babies,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      UserDataResponse(
        id: json["id"],
        email: json["email"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        onboardingDone: json["onboarding_done"],
        wantToBePregnant: json["want_to_be_pregnant"],
        haveMiscarriage: json["have_miscarriage"],
        wantToSeePeriod: json["want_to_see_period"],
        isPregnant: json["is_pregnant"],
        pregnantWeek: json["pregnant_week"],
        firstChild: json["first_child"],
        relation: json["relation"],
        image: json["image"],
        activeLanguage: json["active_language"],
        enableNotifications: json["enable_notifications"],
        babies: json["babies"] == null
            ? []
            : List<Baby>.from(json["babies"]!.map((x) => Baby.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "birthday":
            "${birthday!.year.toString().padLeft(4, '0')}-${birthday!.month.toString().padLeft(2, '0')}-${birthday!.day.toString().padLeft(2, '0')}",
        "onboarding_done": onboardingDone,
        "want_to_be_pregnant": wantToBePregnant,
        "want_to_see_period": wantToSeePeriod,
        "is_pregnant": isPregnant,
        "pregnant_week": pregnantWeek,
        "first_child": firstChild,
        "relation": relation,
        "have_miscarriage": haveMiscarriage,
        "image": image,
        "active_language": activeLanguage,
        "enable_notifications": enableNotifications,
        "babies": babies == null
            ? []
            : List<dynamic>.from(babies!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        phoneNumber,
        birthday,
        onboardingDone,
        wantToBePregnant,
        wantToSeePeriod,
        isPregnant,
        pregnantWeek,
        firstChild,
        haveMiscarriage,
        relation,
        image,
        activeLanguage,
        enableNotifications,
        babies,
      ];
}

class Baby extends Equatable {
  final int? id;
  final List<Indicator>? indicators;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? name;
  final double? weight;
  final double? height;
  final String? gender;
  final DateTime? birthDate;
  final bool? haveBorn;
  final bool? isFirst;
  final bool? haveMiscarriage;
  final int? user;

  const Baby({
    this.id,
    this.indicators,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.name,
    this.weight,
    this.height,
    this.gender,
    this.birthDate,
    this.haveBorn,
    this.isFirst,
    this.haveMiscarriage,
    this.user,
  });

  factory Baby.fromJson(Map<String, dynamic> json) => Baby(
        id: json["id"],
        indicators: json["indicators"] == null
            ? []
            : List<Indicator>.from(
                json["indicators"]!.map((x) => Indicator.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        name: json["name"],
        weight: json["weight"],
        height: json["height"],
        gender: json["gender"],
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        haveBorn: json["have_born"],
        isFirst: json["is_first"],
        haveMiscarriage: json["have_miscarriage"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "indicators": indicators == null
            ? []
            : List<dynamic>.from(indicators!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "name": name,
        "weight": weight,
        "height": height,
        "gender": gender,
        "birth_date":
            "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
        "have_born": haveBorn,
        "is_first": isFirst,
        "have_miscarriage": haveMiscarriage,
        "user": user,
      };

  @override
  List<Object?> get props => [
        id,
        indicators,
        createdAt,
        updatedAt,
        slug,
        name,
        weight,
        height,
        gender,
        birthDate,
        haveBorn,
        isFirst,
        haveMiscarriage,
        user,
      ];
}

class Indicator extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? slug;
  final String? name;
  final String? indicator;
  final DateTime? date;
  final String? time;
  final int? baby;

  const Indicator({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.slug,
    this.name,
    this.indicator,
    this.date,
    this.time,
    this.baby,
  });

  factory Indicator.fromJson(Map<String, dynamic> json) => Indicator(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        name: json["name"],
        indicator: json["indicator"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        baby: json["baby"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "name": name,
        "indicator": indicator,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "baby": baby,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        slug,
        name,
        indicator,
        date,
        time,
        baby,
      ];
}
