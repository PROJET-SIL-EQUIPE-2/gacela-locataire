import 'package:flutter/material.dart';
import 'package:gacela_locataire/models/services/course_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CourseProvider extends ChangeNotifier {
  bool isUnlocked = false;
  String courseStatus = "none"; // waiting, incourse, none, finished
  int? reservationId;

  LatLng? depart = const LatLng(36.737232, 3.086472);
  LatLng? destination = const LatLng(36.365, 6.61472);

  String? carType = "comfort";
  set setCarType(String? carType) {
    this.carType = carType;
  }

  Future<void> unlockCar(
      String? token, int? reservationId, String? code) async {
    final CourseService courseService = CourseService();
    bool result = await courseService.unlockCar(token, reservationId, code);
    isUnlocked = result;
    notifyListeners();
  }

  Future createReservation(
    String? token,
    String? email,
    String? matricule,
  ) async {
    final CourseService courseService = CourseService();
    // currentReservation
    final data = await courseService.createReservation(
        token, email, matricule, depart, destination);
    print(data);
    reservationId = data["reservation_id"];
    notifyListeners();
    return data["reservation_id"];
  }

  Future<Map<String, dynamic>> sendDemandeSupport(
      String? token, String? typeSupport, String? message) async {
    final CourseService courseService = CourseService();
    print("\nhello reservation : $reservationId\n");
    // currentReservation
    final Map<String, dynamic> result = await courseService.sendDemandeSupport(
        token, reservationId, typeSupport, message);

    return result;
  }
}
