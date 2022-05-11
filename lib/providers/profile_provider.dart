import 'package:gacela_locataire/models/services/profile_service.dart';

import '../models/locataire.dart';

class ProfileProvider {
  late Locataire locataire;
  late String token;

  ProfileProvider({
    required this.locataire,
    required this.token,
  });

  Future<Map<String, dynamic>> changePassword(
      String? oldPassword, String? newPassword) async {
    final ProfileService profileService =
        ProfileService(locataire: locataire, token: token);

    return await profileService.changePassword(oldPassword, newPassword);
  }

  Future<Map<String, dynamic>> changeEmail(String? newEmail) async {
    final ProfileService profileService =
        ProfileService(locataire: locataire, token: token);

    return await profileService.changeEmail(newEmail);
  }
}
