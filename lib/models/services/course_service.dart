import 'dart:convert';
import 'dart:io';
import 'package:gacela_locataire/models/location.dart';
import 'package:gacela_locataire/models/reservation.dart';
import 'package:gacela_locataire/models/vehicule_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gacela_locataire/models/errors/failure.dart';

import '../closest_vehicule.dart';

class CourseService {
  /// create a car reservation for a Locataire
  /// @param token
  /// @param email         Locataire email
  /// @param matricule     car matricule
  /// @param depart        depart position
  /// @param destination   destination position
  /// return true if the car is reserved succefully for the locataire else false
  Future<Reservation> createReservation(
    String? token,
    String? email,
    String? matricule,
    Location? depart,
    Location? destination,
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
            "departLat": depart?.lat,
            "departLong": depart?.lng,
            "destLat": destination?.lat,
            "destLong": destination?.lng,
          }));

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return Reservation.fromJson(data["reservation"]);
      } else {
        // final data = jsonDecode(response.body);
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

  /// Unlock a car for a Locataire
  /// @param reservationId     car reservation id
  /// @param code              code de verification
  /// return true if the car is unlocked succefully else false
  Future<Map<String, dynamic>> sendDemandeSupport(String? token,
      int? reservationId, String? typeSupport, String? message) async {
    final String url = '${dotenv.get("BASE_URL")}/supports/$reservationId';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "token": token ?? "",
          },
          body: jsonEncode({"typeSupport": typeSupport, "message": message}));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
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

  /// Unlock a car for a Locataire
  /// @param reservationId     car reservation id
  /// @param code              code de verification
  /// return true if the car is unlocked succefully else false
  Future<List<VehiculeType>> getVehiculeTypes() async {
    final String url = '${dotenv.get("BASE_URL")}/types';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = result["data"] as List;
        return data.map((type) => VehiculeType.fromJson(type)).toList();
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

  Future<ClosestVehicule?> searchClosestVehicule(
      String type, Location depart, Location dest) async {
    final String url = '${dotenv.get("BASE_URL")}/vehicles/search';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "type": type,
            "departLat": depart.lat,
            "departLong": depart.lng,
            "destLat": dest.lat,
            "destLong": dest.lng,
          }));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        final data = result["data"];
        final closestVehiculeJson = data["closest"];
        return ClosestVehicule.fromJson(
            closestVehiculeJson, data["estimatedPrice"]);
      } else {
        final data = jsonDecode(response.body);
        throw Failure(data["data"], code: response.statusCode);
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
