import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gacela_locataire/models/services/auth_service.dart';

class _MyHttpOverrides extends HttpOverrides {}

void main() async {
  HttpOverrides.global = _MyHttpOverrides();
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  test('Login : success case', () async {
    String email = "in_fatmi@esi.dz";
    String password = "resetreset";
    final AuthService authService = AuthService();
    final Map<String, dynamic>? data = await authService.login(email, password);
    final user = data?["user"];
    print(user);
    // ASSERT
  });
}
