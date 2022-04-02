import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Home Screen")],
        ),
      ),
    );
  }
}
