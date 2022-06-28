import 'package:flutter/material.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';

class ThanksCourseScreen extends StatelessWidget {
  static const route = "/thanks-course";
  const ThanksCourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text(
          "Merci, Good Luck",
          style: TextStyle(fontSize: 24),
        ),
        gacelaButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: "Go Home")
      ],
    ));
  }
}
