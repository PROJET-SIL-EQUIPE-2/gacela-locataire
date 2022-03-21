import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const route = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text("Login"))),
    );
  }
}
