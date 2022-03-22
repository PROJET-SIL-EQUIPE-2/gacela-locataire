import 'package:flutter/material.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import '../screens.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  static const route = "/";
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      if (auth.isAuth) {
        return const HomeScreen();
      } else {
        return FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SplashScreen();
              return const LoginScreen();
            });
      }
    });
  }
}
