class DoctorsModel {
  final int? count;
  final String? next;
  final String? previous;
  final List<Doctor>? results;

  DoctorsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory DoctorsModel.fromJson(Map<String, dynamic> json) => DoctorsModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: json["results"] == null
            ? []
            : List<Doctor>.from(
                json["results"]!.map((x) => Doctor.fromJson(x))),
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

class Doctor {
  final int? id;
  final int? userId;
  final int? age;
  final int? schedulingItemId;
  final int? deleteMyDoctorId;
  final String? imageFile;
  final String? name;
  final String? surname;
  final String? patronymic;
  final int? sex;
  final double? totalRaiting;
  final String? education;
  final List<String>? specializations;
  final List<int>? specializationIds;
  final String? scientificDegree;
  final String? workExperience;
  final String? description;
  final int? status;
  final bool? onDuty;

  Doctor({
    this.id,
    this.userId,
    this.age,
    this.schedulingItemId,
    this.deleteMyDoctorId,
    this.imageFile,
    this.name,
    this.surname,
    this.patronymic,
    this.sex,
    this.totalRaiting,
    this.education,
    this.specializations,
    this.specializationIds,
    this.scientificDegree,
    this.workExperience,
    this.description,
    this.status,
    this.onDuty,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        userId: json["userId"],
        age: json["age"],
        schedulingItemId: json["schedulingItemId"],
        deleteMyDoctorId: json["deleteMyDoctorId"],
        imageFile: json["imageFile"],
        name: json["name"],
        surname: json["surname"],
        patronymic: json["patronymic"],
        sex: json["sex"],
        totalRaiting: json["total_raiting"]?.toDouble(),
        education: json["education"],
        specializations: json["specializations"] == null
            ? []
            : List<String>.from(json["specializations"]!.map((x) => x)),
        specializationIds: json["specializationIds"] == null
            ? []
            : List<int>.from(json["specializationIds"]!.map((x) => x)),
        scientificDegree: json["scientific_degree"],
        workExperience: json["work_experience"],
        description: json["description"],
        status: json["status"],
        onDuty: json["onDuty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "age": age,
        "schedulingItemId": schedulingItemId,
        "deleteMyDoctorId": deleteMyDoctorId,
        "imageFile": imageFile,
        "name": name,
        "surname": surname,
        "patronymic": patronymic,
        "sex": sex,
        "total_raiting": totalRaiting,
        "education": education,
        "specializations": specializations == null
            ? []
            : List<dynamic>.from(specializations!.map((x) => x)),
        "specializationIds": specializationIds == null
            ? []
            : List<dynamic>.from(specializationIds!.map((x) => x)),
        "scientific_degree": scientificDegree,
        "work_experience": workExperience,
        "description": description,
        "status": status,
        "onDuty": onDuty,
      };
}
