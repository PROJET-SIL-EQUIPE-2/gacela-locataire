import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  static const route = "/course";
  const CourseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Course Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text("Course Screen")],
        ),
      ),
    );
  }
}
