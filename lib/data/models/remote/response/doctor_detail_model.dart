// To parse this JSON data, do
//
//     final doctorDetailsModel = doctorDetailsModelFromJson(jsonString);

import 'dart:convert';

DoctorDetailsModel doctorDetailsModelFromJson(String str) =>
    DoctorDetailsModel.fromJson(json.decode(str));

String doctorDetailsModelToJson(DoctorDetailsModel data) =>
    json.encode(data.toJson());

class DoctorDetailsModel {
  final int? id;
  final String? name;
  final String? surname;
  final String? patronymic;
  final int? sex;
  final DateTime? birthdate;
  final int? age;
  final String? education;
  final String? imageFile;
  final String? scientificDegree;
  final String? trainingWorkAbroad;
  final String? workExperience;
  final String? additionalInformation;
  final String? language;
  final String? status;
  final double? totalRaiting;
  final dynamic diplom;
  final dynamic diplomserie;
  final dynamic diplomnumber;
  final dynamic certificateserie;
  final dynamic certificatenumber;
  final dynamic code;
  final dynamic contacts; // List<Contact>?
  final dynamic socials; // List<Social>?
  final dynamic diseases; // List<String>?
  final dynamic procedures; // List<String>?
  final dynamic specializations; // List<String>?
  final dynamic prices; // List<Price>?
  final dynamic works; // List<Work>?
  final String? comments; // String?
  final dynamic fullRating; // FullRating?
  final dynamic userRating; // String?
  final int? userAccount; // int?

  DoctorDetailsModel({
    this.id,
    this.name,
    this.surname,
    this.patronymic,
    this.sex,
    this.birthdate,
    this.age,
    this.education,
    this.imageFile,
    this.scientificDegree,
    this.trainingWorkAbroad,
    this.workExperience,
    this.additionalInformation,
    this.language,
    this.status,
    this.totalRaiting,
    this.diplom,
    this.diplomserie,
    this.diplomnumber,
    this.certificateserie,
    this.certificatenumber,
    this.code,
    this.contacts,
    this.socials,
    this.diseases,
    this.procedures,
    this.specializations,
    this.prices,
    this.works,
    this.comments,
    this.fullRating,
    this.userRating,
    this.userAccount,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) =>
      DoctorDetailsModel(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        patronymic: json["patronymic"],
        sex: json["sex"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        age: json["age"],
        education: json["education"],
        imageFile: json["imageFile"],
        scientificDegree: json["scientific_degree"],
        trainingWorkAbroad: json["training_work_abroad"],
        workExperience: json["work_experience"],
        additionalInformation: json["additional_information"],
        language: json["language"],
        status: json["status"],
        totalRaiting: json["total_raiting"]?.toDouble(),
        diplom: json["diplom"],
        diplomserie: json["diplomserie"],
        diplomnumber: json["diplomnumber"],
        certificateserie: json["certificateserie"],
        certificatenumber: json["certificatenumber"],
        code: json["code"],
        contacts: json["contacts"] == null || json["contacts"] is String
            ? []
            : List<Contact>.from(
                json["contacts"]!.map((x) => Contact.fromJson(x))),
        socials: json["socials"] == null || json["socials"] is String
            ? []
            : List<Social>.from(
                json["socials"]!.map((x) => Social.fromJson(x))),
        diseases: json["diseases"] == null || json["diseases"] is String
            ? []
            : List<String>.from(json["diseases"]!.map((x) => x)),
        procedures: json["procedures"] == null || json["procedures"] is String
            ? []
            : List<String>.from(json["procedures"]!.map((x) => x)),
        specializations:
            json["specializations"] == null || json["specializations"] is String
                ? []
                : List<String>.from(json["specializations"]!.map((x) => x)),
        prices: json["prices"] == null || json["prices"] is String
            ? []
            : List<Price>.from(json["prices"]!.map((x) => Price.fromJson(x))),
        works: json["works"] == null || json["works"] is String
            ? []
            : List<Work>.from(json["works"]!.map((x) => Work.fromJson(x))),
        comments: json["comments"],
        fullRating: json["full_rating"] == null || json["full_rating"] is String
            ? null
            : FullRating.fromJson(json["full_rating"]),
        userRating: json["user_rating"] is String ? null : json["user_rating"],
        userAccount: json["user_account"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "sex": sex,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "age": age,
        "education": education,
        "imageFile": imageFile,
        "scientific_degree": scientificDegree,
        "training_work_abroad": trainingWorkAbroad,
        "work_experience": workExperience,
        "additional_information": additionalInformation,
        "language": language,
        "status": status,
        "total_raiting": totalRaiting,
        "diplom": diplom,
        "diplomserie": diplomserie,
        "diplomnumber": diplomnumber,
        "certificateserie": certificateserie,
        "certificatenumber": certificatenumber,
        "code": code,
        "contacts": contacts == null
            ? []
            : List<dynamic>.from(contacts!.map((x) => x.toJson())),
        "socials": socials == null
            ? []
            : List<dynamic>.from(socials!.map((x) => x.toJson())),
        "diseases":
            diseases == null ? [] : List<dynamic>.from(diseases!.map((x) => x)),
        "procedures": procedures == null
            ? []
            : List<dynamic>.from(procedures!.map((x) => x)),
        "specializations": specializations == null
            ? []
            : List<dynamic>.from(specializations!.map((x) => x)),
        "prices": prices == null
            ? []
            : List<dynamic>.from(prices!.map((x) => x.toJson())),
        "works": works == null
            ? []
            : List<dynamic>.from(works!.map((x) => x.toJson())),
        "comments": comments,
        "full_rating": fullRating?.toJson(),
        "user_rating": userRating,
        "user_account": userAccount,
      };
}

class Contact {
  final String? telefon;
  final String? ePot;
  final String? nternetShif;

  Contact({
    this.telefon,
    this.ePot,
    this.nternetShif,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        telefon: json["Telefon"],
        ePot: json["E-poçt"],
        nternetShif: json["İnternet səhifə"],
      );

  Map<String, dynamic> toJson() => {
        "Telefon": telefon,
        "E-poçt": ePot,
        "İnternet səhifə": nternetShif,
      };
}

class FullRating {
  final int? count;
  final double? total;
  final double? waitingTime;
  final int? mindfulness;
  final double? professionalism;
  final double? qualityService;
  final double? diagnosisClear;
  final int? atmosphere;
  final double? relevancePrice;

  FullRating({
    this.count,
    this.total,
    this.waitingTime,
    this.mindfulness,
    this.professionalism,
    this.qualityService,
    this.diagnosisClear,
    this.atmosphere,
    this.relevancePrice,
  });

  factory FullRating.fromJson(Map<String, dynamic> json) => FullRating(
        count: json["count"],
        total: json["total"]?.toDouble(),
        waitingTime: json["waiting_time"]?.toDouble(),
        mindfulness: json["mindfulness"],
        professionalism: json["professionalism"]?.toDouble(),
        qualityService: json["quality_service"]?.toDouble(),
        diagnosisClear: json["diagnosis_clear"]?.toDouble(),
        atmosphere: json["atmosphere"],
        relevancePrice: json["relevance_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "waiting_time": waitingTime,
        "mindfulness": mindfulness,
        "professionalism": professionalism,
        "quality_service": qualityService,
        "diagnosis_clear": diagnosisClear,
        "atmosphere": atmosphere,
        "relevance_price": relevancePrice,
      };
}

class Price {
  final String? clinicId;
  final dynamic paymentMethod;
  final String? firstConsSum;
  final String? secondConsSum;
  final String? homeConsSum;
  final int? firstOnlineSum;
  final int? secondOnlineSum;
  final int? dutyPrice;

  Price({
    this.clinicId,
    this.paymentMethod,
    this.firstConsSum,
    this.secondConsSum,
    this.homeConsSum,
    this.firstOnlineSum,
    this.secondOnlineSum,
    this.dutyPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        clinicId: json["Clinic ID"],
        paymentMethod: json["Payment Method"],
        firstConsSum: json["First Cons Sum"],
        secondConsSum: json["Second Cons Sum"],
        homeConsSum: json["Home Cons Sum"],
        firstOnlineSum: json["First Online Sum"],
        secondOnlineSum: json["Second Online Sum"],
        dutyPrice: json["Duty Price"],
      );

  Map<String, dynamic> toJson() => {
        "Clinic ID": clinicId,
        "Payment Method": paymentMethod,
        "First Cons Sum": firstConsSum,
        "Second Cons Sum": secondConsSum,
        "Home Cons Sum": homeConsSum,
        "First Online Sum": firstOnlineSum,
        "Second Online Sum": secondOnlineSum,
        "Duty Price": dutyPrice,
      };
}

class Social {
  final String? facebook;
  final String? instaqram;

  Social({
    this.facebook,
    this.instaqram,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        facebook: json["Facebook"],
        instaqram: json["Instaqram"],
      );

  Map<String, dynamic> toJson() => {
        "Facebook": facebook,
        "Instaqram": instaqram,
      };
}

class Work {
  final String? clinicId;
  final String? workingTime;
  final int? homeVisit;
  final int? childrenOnly;

  Work({
    this.clinicId,
    this.workingTime,
    this.homeVisit,
    this.childrenOnly,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        clinicId: json["Clinic ID"],
        workingTime: json["Working Time"],
        homeVisit: json["Home Visit"],
        childrenOnly: json["Children Only"],
      );

  Map<String, dynamic> toJson() => {
        "Clinic ID": clinicId,
        "Working Time": workingTime,
        "Home Visit": homeVisit,
        "Children Only": childrenOnly,
      };
}
