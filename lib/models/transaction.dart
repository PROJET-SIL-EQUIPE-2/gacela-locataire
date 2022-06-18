class Transaction {
  Transaction({
    this.reservationId,
    this.locataireId,
    this.vehiculeId,
    this.code,
    this.etat,
    this.departLat,
    this.departLong,
    this.destLat,
    this.destLong,
    this.dateReservation,
    this.realStartCourse,
    this.realEndCourse,
    String? matricule,
  });

  int? reservationId;
  int? locataireId;
  int? vehiculeId;
  dynamic code;
  String? etat;
  double? departLat;
  double? departLong;
  double? destLat;
  double? destLong;
  DateTime? dateReservation;
  dynamic realStartCourse;
  dynamic realEndCourse;
  String? matricule;

  factory Transaction.fromJson(Map<String, dynamic> json, String? matricule) =>
      Transaction(
        reservationId: json["reservation_id"],
        locataireId: json["locataire_id"],
        vehiculeId: json["vehicule_id"],
        code: json["code"],
        etat: json["etat"],
        departLat: json["departLat"],
        departLong: json["departLong"],
        destLat: json["destLat"],
        destLong: json["destLong"],
        dateReservation: DateTime.parse(json["date_reservation"]),
        realStartCourse: json["real_start_course"],
        realEndCourse: json["real_end_course"],
        matricule: matricule,
      );
}
