import 'package:gacela_locataire/models/agent.dart';

class ClosestVehicule {
  ClosestVehicule({
    this.vehiculeId,
    this.matricule,
    this.carPhoto,
    this.responsable,
    this.typeVehicule,
    this.kilometrage,
    this.etat,
    this.disponible,
    this.locked,
    this.region,
    this.agent,
    this.estimatedPrice,
  });

  int? vehiculeId;
  String? matricule;
  dynamic carPhoto;
  int? responsable;
  int? typeVehicule;
  int? kilometrage;
  String? etat;
  bool? disponible;
  bool? locked;
  dynamic region;
  Agent? agent;
  double? estimatedPrice;

  factory ClosestVehicule.fromJson(
          Map<String, dynamic> json, double? estimatedPrice) =>
      ClosestVehicule(
          vehiculeId: json["vehicule_id"],
          matricule: json["matricule"],
          carPhoto: json["car_photo"],
          responsable: json["responsable"],
          typeVehicule: json["type_vehicule"],
          kilometrage: json["kilometrage"],
          etat: json["etat"],
          disponible: json["disponible"],
          locked: json["locked"],
          region: json["region"],
          estimatedPrice: estimatedPrice,
          agent: Agent.fromJson(json["AgentsMaintenance"]));
}
