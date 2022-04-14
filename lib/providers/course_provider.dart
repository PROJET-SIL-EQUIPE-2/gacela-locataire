import 'package:flutter/material.dart';
import 'package:gacela_locataire/models/services/course_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CourseProvider extends ChangeNotifier {
  bool isUnlocked = false;
  String courseStatus = "none"; // waiting, incourse, none, finished
  int? _currentReservation;

  int? get currentReservation => _currentReservation;

  Future<void> unlockCar(
      String? token, int? reservationId, String? code) async {
    final CourseService courseService = CourseService();
    bool result = await courseService.unlockCar(token, reservationId, code);
    isUnlocked = result;
    notifyListeners();
  }

  Future<bool> createReservation(
    String? token,
    String? email,
    String? matricule,
    LatLng? depart,
    LatLng? destination,
  ) async {
    final CourseService courseService = CourseService();
    // currentReservation
    return await courseService.createReservation(
        token, email, matricule, depart, destination);
  }
}
