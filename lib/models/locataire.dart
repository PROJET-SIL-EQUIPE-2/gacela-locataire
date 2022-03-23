import 'dart:convert';

Locataire locataireFromJson(String str) => Locataire.fromJson(json.decode(str));

class Locataire {
  Locataire({
    this.id,
    this.email,
    this.phoneNumber,
    this.name,
    this.familyName,
    this.validated,
    this.personalPhoto,
    this.photoIdentity,
  });

  int? id;
  String? email;
  String? phoneNumber;
  String? name;
  String? familyName;
  bool? validated;
  dynamic personalPhoto;
  dynamic photoIdentity;

  factory Locataire.fromJson(Map<String, dynamic> json) => Locataire(
        id: json["data"]["id"],
        email: json["data"]["email"],
        phoneNumber: json["data"]["phone_number"],
        name: json["data"]["name"],
        familyName: json["data"]["family_name"],
        validated: json["data"]["validated"],
        personalPhoto: json["data"]["personal_photo"],
        photoIdentity: json["data"]["photo_identity"],
      );

  Map<String, String> toJson(String? password) => {
        "email": email.toString(),
        "phone_number": phoneNumber.toString(),
        "name": name.toString(),
        "family_name": familyName.toString(),
        "password": password.toString(),
      };
}
