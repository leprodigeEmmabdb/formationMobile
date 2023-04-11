// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    this.id,
    this.username,
  });

  int? id;
  String? username;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
  };
}