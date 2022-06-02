class Reservation {
  Reservation({
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

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
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
      );
}
