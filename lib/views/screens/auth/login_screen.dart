import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const route = "/";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Login Screen"),
      ),
    );
  }
}
