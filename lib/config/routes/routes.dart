import 'package:flutter/material.dart';
import '../../views/screens/wrapper.dart';
import '../../views/screens.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Wrapper.route: (_) => const Wrapper(),
    LoginScreen.route: (_) => const LoginScreen(),
    RegisterScreen.route: (_) => const RegisterScreen(),
    IntroScreen.route: (_) => const IntroScreen(),
    ResetPasswordScreen.route: (_) => const ResetPasswordScreen(),
    ThanksScreen.route: (_) => const ThanksScreen(),
    MainScreen.route: (_) => const MainScreen()
  };
}
