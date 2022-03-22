import 'dart:convert';

/**
 * FIXME:
 * Not completed
 * Just an exemple of the Locataire model
 */

Locataire locataireFromJson(String str) => Locataire.fromJson(json.decode(str));

String locataireToJson(Locataire data) => json.encode(data.toJson());

class Locataire {
  Locataire({
    this.id,
    this.email,
    this.nom,
    this.prenom,
    this.birthday,
  });

  late final int? id;
  final String? email;
  final String? nom;
  final String? prenom;
  final DateTime? birthday;

  factory Locataire.fromJson(Map<String, dynamic> json) => Locataire(
        id: json["data"]["id"],
        email: json["data"]["email"],
        nom: json["data"]["nom"],
        prenom: json["data"]["prenom"],
        birthday: json["data"]["birthday"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "nom": nom,
        "prenom": prenom,
        "birthday": birthday,
      };
}
