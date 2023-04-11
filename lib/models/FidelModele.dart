// To parse this JSON data, do
//
//     final fidelModele = fidelModeleFromJson(jsonString);

import 'dart:convert';

FidelModele fidelModeleFromJson(String str) => FidelModele.fromJson(json.decode(str));

String fidelModeleToJson(FidelModele data) => json.encode(data.toJson());

class FidelModele {
  FidelModele({
    this.id,
    this.nom,
    this.prenom,
    this.age,
    this.image,
  });

  int? id;
  String? nom;
  String? prenom;
  int? age;
  String? image;

  factory FidelModele.fromJson(Map json) => FidelModele(
    id: json["id"],
    nom: json["nom"],
    prenom: json["prenom"],
    age: json["age"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
    "prenom": prenom,
    "age": age,
    "image": image,
  };
}

