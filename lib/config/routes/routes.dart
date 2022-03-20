import 'package:flutter/material.dart';
import '../../views/screens/wrapper.dart';
import '../../views/screens.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Wrapper.route: (_) => const Wrapper(),
    LoginScreen.route: (_) => const LoginScreen(),
  };
}
