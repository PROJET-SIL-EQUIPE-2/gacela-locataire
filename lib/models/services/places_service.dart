import 'dart:convert';

import 'package:gacela_locataire/models/errors/failure.dart';
import 'package:gacela_locataire/models/place.dart';
import 'package:gacela_locataire/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesService {
  Future<List<PlaceSearch>> getAutoComplete(String? search) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=geocode&language=en&key=${dotenv.get("GOOGLE_API_KEY")}';
    try {
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final jsonResult = json["predictions"] as List;
        if (jsonResult.isEmpty) return [];
        return jsonResult.map((place) => PlaceSearch.fromJson(place)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<Place?> getPlace(String? placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?key=${dotenv.get("GOOGLE_API_KEY")}&place_id=$placeId';
    try {
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final jsonResult = json["result"] as Map<String, dynamic>;
        return Place.fromJson(jsonResult);
      } else {
        return null;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
