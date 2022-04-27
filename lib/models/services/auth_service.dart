import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../locataire.dart';
import '../errors/failure.dart';

class AuthService {
  /// La connexion d'un locataire
  /// @param email      the email of the user
  /// @param password   the password of the user
  /// return a user if the email and password are true else return a Failure exception
  Future<Map<String, dynamic>?> login(String? email, String? password) async {
    final String url = '${dotenv.get("BASE_URL")}/mobile_login/locataire';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
            "password": password,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "user": locataireFromJson(response.body),
          "token": data["token"]
        };
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

  Future<Map<String, dynamic>?> register(
      Locataire? locataire, String? password) async {
    final String url = '${dotenv.get("BASE_URL")}/signup/locataire';
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      request.files.add(
        http.MultipartFile(
          'photo_identity',
          locataire!.photoIdentity.readAsBytes().asStream(),
          await locataire.photoIdentity.length(),
          filename: locataire.photoIdentity.name,
          contentType:
              MediaType('image', locataire.photoIdentity.name.split(".")[1]),
        ),
      );
      request.files.add(
        http.MultipartFile(
          'personal_photo',
          locataire.personalPhoto.readAsBytes().asStream(),
          await locataire.personalPhoto.length(),
          filename: locataire.personalPhoto.name,
          contentType:
              MediaType('image', locataire.personalPhoto.name.split(".")[1]),
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll(locataire.toJson(password));
      final response = await request.send();
      final dataAsString = await response.stream.bytesToString();
      print(dataAsString);
      final data = json.decode(dataAsString);
      if (response.statusCode == 201) {
        return data;
      } else {
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

  /// reset le password d'un locataire
  /// @param email      the email of the user
  /// returns a message if success else returns a failure
  Future<String?> resetPassword(String? email) async {
    final String url =
        '${dotenv.get("BASE_URL")}/mobile_passwordReset/locataire';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
          }));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["message"];
      } else {
        final data = jsonDecode(response.body);
        throw Failure(data["message"], code: response.statusCode);
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
