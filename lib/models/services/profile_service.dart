import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../locataire.dart';
import '../errors/failure.dart';

class ProfileService {
  late Locataire locataire;
  late String token;

  ProfileService({
    required this.locataire,
    required this.token,
  });

  Future<Map<String, dynamic>> changePassword(
      String? oldPassword, String? newPassword) async {
    final String url =
        '${dotenv.get("BASE_URL")}/mobile_settings/locataire/password/${locataire.id}';
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "oldPassword": oldPassword,
            "newPassword": newPassword,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {"success": true, "msg": data["errors"][0]["msg"]};
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
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> changeEmail(String? newEmail) async {
    final String url =
        '${dotenv.get("BASE_URL")}/mobile_settings/locataire/email/${locataire.id}';
    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": newEmail,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {"success": true, "msg": data["errors"][0]["msg"]};
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
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }
}
