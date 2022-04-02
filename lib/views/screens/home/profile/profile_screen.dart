import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const route = "/profile";
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Profile Screen")],
        ),
      ),
    );
  }
}
