import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  static const route = "/";
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Support Screen")],
        ),
      ),
    );
  }
}
