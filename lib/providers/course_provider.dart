import 'package:flutter/material.dart';
import 'package:gacela_locataire/models/geometry.dart';
import 'package:gacela_locataire/models/location.dart';
import 'package:gacela_locataire/models/place.dart';
import 'package:gacela_locataire/models/place_search.dart';
import 'package:gacela_locataire/models/reservation.dart';
import 'package:gacela_locataire/models/services/course_service.dart';
import 'package:gacela_locataire/models/services/places_service.dart';
import 'package:gacela_locataire/models/vehicule_type.dart';
import 'package:geolocator/geolocator.dart';

import '../models/closest_vehicule.dart';
import '../models/services/geolocator_service.dart';
import 'payment_provider.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider() {
    setCurrentLocation();
  }

  bool isUnlocked = false;
  String courseStatus = "none"; // waiting, incourse, none, finished
  Reservation? currentReservation;
  ClosestVehicule? closestVehicule;
  bool isPayed = false;

  Future<void> unlockCar(
      String? token, int? reservationId, String? code) async {
    final CourseService courseService = CourseService();
    bool result = await courseService.unlockCar(token, reservationId, code);
    isUnlocked = result;
    notifyListeners();
  }

  Future<void> createReservation(
    String? token,
    String? email,
    String? matricule,
  ) async {
    final CourseService courseService = CourseService();
    // currentReservation
    currentReservation = await courseService.createReservation(
        token,
        email,
        matricule,
        departPlace?.geometry.location,
        destinationPlace?.geometry.location);
    notifyListeners();
  }

  Future<Map<String, dynamic>> sendDemandeSupport(
      String? token, String? typeSupport, String? message) async {
    final CourseService courseService = CourseService();
    // currentReservation
    final Map<String, dynamic> result = await courseService.sendDemandeSupport(
        token, currentReservation?.reservationId, typeSupport, message);

    return result;
  }

  Future<List<VehiculeType>> getVehiculeTypes() async {
    final CourseService courseService = CourseService();
    return await courseService.getVehiculeTypes();
  }

  Future<void> searchClosestVehicule(String type) async {
    final CourseService courseService = CourseService();
    closestVehicule = await courseService.searchClosestVehicule(type,
        departPlace!.geometry.location, destinationPlace!.geometry.location);
    notifyListeners();
  }

  // geo location *************************************************
  final GeolocatorService geolocatorService = GeolocatorService();
  final PlacesService placesService = PlacesService();

  Position? currentLocation;
  List<PlaceSearch> searchResult = [];

  Place? departPlace;
  Place? destinationPlace;

  Future<void> setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String? searchTerm) async {
    searchResult = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  getPlaceDetails(String placeId, bool isDepart) async {
    Place? place = await placesService.getPlace(placeId);
    if (isDepart) {
      departPlace = place;
    } else {
      destinationPlace = place;
    }
    return place;
  }

  Future<Place> setCurrentLocationPlace(bool isDepart) async {
    currentLocation ??= await geolocatorService.getCurrentLocation();
    Place? place = Place(
      geometry: Geometry(
          location: Location(
              lat: currentLocation!.latitude, lng: currentLocation!.longitude)),
      name: "${currentLocation!.latitude}, ${currentLocation!.longitude}",
    );
    if (isDepart) {
      departPlace = place;
    } else {
      destinationPlace = place;
    }
    return place;
  }

  Future<void> makePayment() async {
    final PaymentController controller = PaymentController();
    try {
      bool isDonne = await controller.makePayment(
          amount: closestVehicule!.estimatedPrice!.toStringAsFixed(0),
          currency: 'USD',
          reservationId: currentReservation?.reservationId);

      if (isDonne) {
        isPayed = true;
      } else {
        isPayed = false;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
