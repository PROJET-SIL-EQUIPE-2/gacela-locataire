import 'package:gacela_locataire/models/transaction.dart';

import 'abstract_provider.dart';
import '../models/notifier_state.dart';
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

  int? reservation;

  clearMessage() => _message = null;

  Locataire? get user => _user;

  bool get isAuth {
    // && _isAuth == true && _token != null
    if (_isAuth != null && _isAuth == true) {
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
        print(_user);
        _token = data!["token"];
        _isAuth = true;
        final LocalStorageService localStorageService = LocalStorageService();
        await localStorageService.saveUser(_token, _user?.id, _user);
        setProviderState(NotifierState.loaded);
      }
    } on Failure catch (f) {
      // error case
      setProviderFailure(f);
      setProviderState(NotifierState.initial);
    }
  }

  Future<bool?> register(Locataire? locataire, String? password) async {
    setProviderFailure(null);
    final AuthService authService = AuthService();
    // set the state to loading => show progress
    setProviderState(NotifierState.loading);
    try {
      // get the data
      final Map<String, dynamic>? data =
          await authService.register(locataire, password);
      return true;
    } on Failure catch (f) {
      // error case
      setProviderFailure(f);
      setProviderState(NotifierState.loaded);
    }
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
      _user = Locataire(
        id: int.parse(userData["user"]["user_id"]),
        email: userData["user"]["email"],
        familyName: userData["user"]["family_name"],
        name: userData["user"]["name"],
        phoneNumber: userData["user"]["phone_number"],
        personalPhoto: userData["user"]["personal_photo"],
        photoIdentity: userData["user"]["photo_identity"],
        validated: userData["user"]["validated"],
      );
      notifyListeners();
      return true;
    }
  }

  Future<bool> logout() async {
    try {
      _isAuth = false;
      _token = null;
      _user = null;
      clearMessage();
      await LocalStorageService.clearLocalStorage();
      setProviderState(NotifierState.initial);
      setProviderFailure(null);
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

  List<Transaction> transactionsList = [];
  Future<void> getTransactions() async {
    AuthService authService = AuthService();
    transactionsList = await authService.getTransactions(user?.email);
    notifyListeners();
  }
}
