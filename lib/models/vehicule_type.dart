class VehiculeType {
  VehiculeType({
    this.typeId,
    this.type,
    this.pricePerHour,
  });

  int? typeId;
  String? type;
  int? pricePerHour;

  factory VehiculeType.fromJson(Map<String, dynamic> json) => VehiculeType(
        typeId: json["type_id"],
        type: json["type"],
        pricePerHour: json["price_per_hour"],
      );
}
