import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  static const route = "/";
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Transactions Screen")],
        ),
      ),
    );
  }
}
