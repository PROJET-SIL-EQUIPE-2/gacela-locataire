import '../models/notifier_state.dart';
import 'abstract_provider.dart';
import '../models/locataire.dart';
import '../models/services/auth_service.dart';
import '../models/errors/failure.dart';
import '../models/services/localstorage_service.dart';

class AuthProvider extends AbstractProvider {
  // is the user connected
  bool? _isAuth;
  // the current user data
  Locataire? _user;
  // current user auth token
  String? _token;
  //Show a message to user
  String? _message;

  String? get message => _message;

  clearMessage() => _message = null;

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
    setProviderFailure(null);
    final AuthService authService = AuthService();
    // set the state to loading => show progress
    setProviderState(NotifierState.loading);
    try {
      // get the data
      final Map<String, dynamic>? data =
          await authService.login(email, password);
      _user = data?["user"];
      print(_user);
      if (_user != null) {
        _token = data!["token"];
        _isAuth = true;
        final LocalStorageService localStorageService = LocalStorageService();
        await localStorageService.saveUser(_token, _user?.id);
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

  Future<bool> tryAutoLogin() async {
    final userData = await LocalStorageService.getUser();
    if (userData == null) {
      _isAuth = false;
      _token = null;
      return false;
    } else {
      _isAuth = true;
      _token = userData["gacela_token"];
      _user = Locataire(id: int.parse(userData["user_id"]));
      notifyListeners();
      return true;
    }
  }

  Future<bool> logout() async {
    try {
      _isAuth = false;
      _token = null;
      _user = null;
      await LocalStorageService.clearLocalStorage();
      setProviderState(NotifierState.initial);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> resetPassword(String? email) async {
    setProviderFailure(null);
    _message = null;
    final AuthService authService = AuthService();
    // set the state to loading => show progress
    setProviderState(NotifierState.loading);
    try {
      // get the data
      _message = await authService.resetPassword(email);
    } on Failure catch (f) {
      setProviderFailure(f);
    }
    setProviderState(NotifierState.loaded);
  }
}
