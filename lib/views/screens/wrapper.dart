import 'package:flutter/material.dart';
import 'package:gacela_locataire/views/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const route = "/";
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, auth, _) {
      // TODO: Decide if show LoginScreen or HomeScreen => It depends on the user status
      return const LoginScreen();
    });
  }
}
