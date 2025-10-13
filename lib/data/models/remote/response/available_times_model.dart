class AvailableTimesModel {
  final List<AvailableTimes>? results;

  AvailableTimesModel({
    this.results,
  });

  factory AvailableTimesModel.fromJson(Map<String, dynamic> json) =>
      AvailableTimesModel(
        results: json["results"] == null
            ? []
            : List<AvailableTimes>.from(
                json["results"]!.map((x) => AvailableTimes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class AvailableTimes {
  final int? id;
  final int? doctorId;
  final dynamic patientId;
  final DateTime? start;
  final DateTime? end;
  final DateTime? created;
  final DateTime? updated;
  final bool? onDuty;
  final bool? active;
  final bool? online;
  final bool? offline;
  final bool? home;
  final int? clinicId;
  final dynamic currentRecordId;
  final int? doctorDescId;
  final bool? asPatient;
  final dynamic patientName;
  final dynamic patientImage;
  final String? doctorName;
  final String? doctorImage;
  final dynamic status;

  AvailableTimes({
    this.id,
    this.doctorId,
    this.patientId,
    this.start,
    this.end,
    this.created,
    this.updated,
    this.onDuty,
    this.active,
    this.online,
    this.offline,
    this.home,
    this.clinicId,
    this.currentRecordId,
    this.doctorDescId,
    this.asPatient,
    this.patientName,
    this.patientImage,
    this.doctorName,
    this.doctorImage,
    this.status,
  });

  factory AvailableTimes.fromJson(Map<String, dynamic> json) => AvailableTimes(
        id: json["id"],
        doctorId: json["doctorId"],
        patientId: json["patientId"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        onDuty: json["onDuty"],
        active: json["active"],
        online: json["online"],
        offline: json["offline"],
        home: json["home"],
        clinicId: json["clinicId"],
        currentRecordId: json["currentRecordId"],
        doctorDescId: json["doctorDescId"],
        asPatient: json["asPatient"],
        patientName: json["patientName"],
        patientImage: json["patientImage"],
        doctorName: json["doctorName"],
        doctorImage: json["doctorImage"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "doctorId": doctorId,
        "patientId": patientId,
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "onDuty": onDuty,
        "active": active,
        "online": online,
        "offline": offline,
        "home": home,
        "clinicId": clinicId,
        "currentRecordId": currentRecordId,
        "doctorDescId": doctorDescId,
        "asPatient": asPatient,
        "patientName": patientName,
        "patientImage": patientImage,
        "doctorName": doctorName,
        "doctorImage": doctorImage,
        "status": status,
      };
}
