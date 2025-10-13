import 'dart:convert';

import 'package:burla_xatun/data/models/local/user_data_model.dart';

UserResponseModel userResponseModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userResponseModelToJson(UserResponseModel data) =>
    json.encode(data.toJson());

class UserResponseModel {
  final int status;
  final String message;
  final UserData data;

  UserResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        status: json["status"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  final String id;
  final String email;
  final String name;
  final String surname;
  final String fathername;
  final String birthdate;
  final String parentType;
  final String phone;
  final String avatar;
  final String parentName;
  final int age;

  UserData({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.fathername,
    required this.birthdate,
    required this.parentType,
    required this.phone,
    required this.avatar,
    required this.parentName,
    required this.age,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
        fathername: json["fathername"],
        birthdate: json["birthdate"],
        parentType: json["parent_type"],
        phone: json["phone"],
        avatar: json["avatar"],
        parentName: json["parent_name"],
        age: json["age"],
      );

  UserDataModel toHiveModel() {
    return UserDataModel(
      id: id,
      email: email,
      name: name,
      surname: surname,
      fatherName: fathername,
      birthDate: birthdate,
      parentType: parentType,
      phone: phone,
      avatar: avatar,
      parentName: parentName,
      age: age,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "surname": surname,
        "fathername": fathername,
        "birthdate": birthdate,
        "parent_type": parentType,
        "phone": phone,
        "avatar": avatar,
        "parent_name": parentName,
        "age": age,
      };
}
