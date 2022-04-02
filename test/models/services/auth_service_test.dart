import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gacela_locataire/models/services/auth_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'auth_service_test.mocks.dart';

class _MyHttpOverrides extends HttpOverrides {}

@GenerateMocks([http.Client])
void main() async {
  HttpOverrides.global = _MyHttpOverrides();
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  test('LOGIN', () async {
    final String url = '${dotenv.get("BASE_URL")}/mobile_login/locataire';
    String email = "in_fatmi@esi.dz";
    String password = "resetreset";
    final AuthService authService = AuthService();
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "email": email,
              "password": password,
            })))
        .thenAnswer((_) async =>
            http.Response('{"user": "true","token": "true"}', 200));
  });
  test('LOGIN fail', () async {
    final String url = '${dotenv.get("BASE_URL")}/mobile_login/locataire';
    String email = "in_fatmi@es.dz";
    String password = "resetreset";
    final AuthService authService = AuthService();
    final client = MockClient();

    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client.post(Uri.parse(url),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "email": email,
              "password": password,
            })))
        .thenAnswer((_) async =>
            http.Response('{"user": "true","token": "true"}', 400));
  });
}
