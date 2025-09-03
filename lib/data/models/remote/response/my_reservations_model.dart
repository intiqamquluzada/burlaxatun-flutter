class DoctorNotificationModel {
  final int? id;
  final String? doctorSlug;
  final String? doctorName;
  final String? doctorSurname;
  final String? doctorImage;
  final String? doctorPosition;
  final String? doctorWorkplace;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? reserveDate;
  final String? reserveTime;
  final String? status;
  final int? user;
  final int? doctor;

  DoctorNotificationModel({
    this.id,
    this.doctorSlug,
    this.doctorName,
    this.doctorSurname,
    this.doctorImage,
    this.doctorPosition,
    this.doctorWorkplace,
    this.createdAt,
    this.updatedAt,
    this.reserveDate,
    this.reserveTime,
    this.status,
    this.user,
    this.doctor,
  });

  factory DoctorNotificationModel.fromJson(Map<String, dynamic> json) =>
      DoctorNotificationModel(
        id: json["id"],
        doctorSlug: json["doctor_slug"],
        doctorName: json["doctor_name"],
        doctorSurname: json["doctor_surname"],
        doctorImage: json["doctor_image"],
        doctorPosition: json["doctor_position"],
        doctorWorkplace: json["doctor_workplace"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        reserveDate: json["reserve_date"] == null
            ? null
            : DateTime.parse(json["reserve_date"]),
        reserveTime: json["reserve_time"],
        status: json["status"],
        user: json["user"],
        doctor: json["doctor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctor_slug": doctorSlug,
        "doctor_name": doctorName,
        "doctor_surname": doctorSurname,
        "doctor_image": doctorImage,
        "doctor_position": doctorPosition,
        "doctor_workplace": doctorWorkplace,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "reserve_date":
            "${reserveDate!.year.toString().padLeft(4, '0')}-${reserveDate!.month.toString().padLeft(2, '0')}-${reserveDate!.day.toString().padLeft(2, '0')}",
        "reserve_time": reserveTime,
        "status": status,
        "user": user,
        "doctor": doctor,
      };
}

// class MyReservationsModel {
//   final int? id;
//   final String? doctorName;
//   final String? doctorSurname;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final DateTime? reserveDate;
//   final String? reserveTime;
//   final String? status;
//   final int? user;
//   final int? doctor;

//   MyReservationsModel({
//     this.id,
//     this.doctorName,
//     this.doctorSurname,
//     this.createdAt,
//     this.updatedAt,
//     this.reserveDate,
//     this.reserveTime,
//     this.status,
//     this.user,
//     this.doctor,
//   });

//   factory MyReservationsModel.fromJson(Map<String, dynamic> json) =>
//       MyReservationsModel(
//         id: json["id"],
//         doctorName: json["doctor_name"],
//         doctorSurname: json["doctor_surname"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//         reserveDate: json["reserve_date"] == null
//             ? null
//             : DateTime.parse(json["reserve_date"]),
//         reserveTime: json["reserve_time"],
//         status: json["status"],
//         user: json["user"],
//         doctor: json["doctor"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "doctor_name": doctorName,
//         "doctor_surname": doctorSurname,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "reserve_date":
//             "${reserveDate!.year.toString().padLeft(4, '0')}-${reserveDate!.month.toString().padLeft(2, '0')}-${reserveDate!.day.toString().padLeft(2, '0')}",
//         "reserve_time": reserveTime,
//         "status": status,
//         "user": user,
//         "doctor": doctor,
//       };
// }
