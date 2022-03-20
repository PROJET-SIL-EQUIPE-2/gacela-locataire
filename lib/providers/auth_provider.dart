import '../models/notifier_state.dart';
import 'abstract_provider.dart';
import '../models/locataire.dart';
import '../models/services/auth_service.dart';
import '../models/errors/failure.dart';

class AuthProvider extends AbstractProvider {
  // is the user connected
  bool? _isAuth;
  // the current user data
  Locataire? _user;
  // current user auth token
  String? _token;

  Locataire? get user => _user;

  bool get isAuth {
    if (_isAuth != null && _isAuth == true && _token != null) {
      return true;
    } else {
      return false;
    }
  }

  String? get token => _token;

  Future<void> login(String? email, String? password) async {
    final AuthService authService = AuthService();
    // set the state to loading => show progress
    setProviderState(NotifierState.loading);
    try {
      // get the data
      _user = await authService.login(email, password);
      if (_user != null) {
        // TODO: Call LocalStorageService to save the user into the localStorage
      }
    } on Failure catch (f) {
      // error case
      setProviderFailure(f);
    }
    setProviderState(NotifierState.loaded);
  }

  Future<void> signup(Locataire? locataire) async {
    // TODO:
    throw UnimplementedError("Signup not implemanted");
  }
}
