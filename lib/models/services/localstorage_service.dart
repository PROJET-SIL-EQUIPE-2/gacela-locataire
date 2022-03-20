import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  /// Save user info in the localstorage of the device
  /// @param token      auth token
  /// @param userId     represent the user id
  /// returns true if saved else false
  Future<bool> saveUser(String? token, int? userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final body = {
        "karini_token": token,
        "user_id": userId.toString(),
      };
      await prefs.setString(
        "KariniUserData",
        json.encode(body),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Get user info from the localstorage
  /// return
  Future<Map<String, dynamic>?> getUser() async {
    // TODO: Implemant get User function
    throw UnimplementedError();
  }
}
