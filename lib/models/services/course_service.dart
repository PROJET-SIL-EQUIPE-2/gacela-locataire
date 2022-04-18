import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gacela_locataire/models/errors/failure.dart';

class CourseService {
  /// create a car reservation for a Locataire
  /// @param token
  /// @param email         Locataire email
  /// @param matricule     car matricule
  /// @param depart        depart position
  /// @param destination   destination position
  /// return true if the car is reserved succefully for the locataire else false
  Future<int> createReservation(
    String? token,
    String? email,
    String? matricule,
    LatLng? depart,
    LatLng? destination,
  ) async {
    final String url =
        '${dotenv.get("BASE_URL")}/reservations/create-reservation';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "token": token ?? "",
          },
          body: jsonEncode({
            "locataire": email,
            "matricule": matricule,
            "departLat": depart?.latitude,
            "departLong": depart?.longitude,
            "destLat": destination?.latitude,
            "destLong": destination?.longitude,
          }));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        print(response.body);
        print(data["reservation"]["reservation_id"]);
        return (data["reservation"]["reservation_id"]);
      } else {
        final data = jsonDecode(response.body);
        print(response.body);
        throw Failure("Il ya un erreur", code: response.statusCode);
      }
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  /// Unlock a car for a Locataire
  /// @param reservationId     car reservation id
  /// @param code              code de verification
  /// return true if the car is unlocked succefully else false
  Future<bool> unlockCar(
      String? token, int? reservationId, String? code) async {
    final String url = '${dotenv.get("BASE_URL")}/reservations/verify-code';
    print("\n${reservationId}\n\n");
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "token": token ?? "",
          },
          body: jsonEncode({"reservation_id": reservationId, "code": code}));

      if (response.statusCode == 200) {
        // final data = json.decode(response.body);
        return true;
      } else {
        final data = jsonDecode(response.body);
        throw Failure(data["errors"][0]["msg"], code: response.statusCode);
      }
    } on SocketException {
      throw Failure('No Internet connection 😑');
    } on HttpException {
      throw Failure("Couldn't find the post 😱");
    } on FormatException {
      throw Failure("Bad response format 👎");
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
