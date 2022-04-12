// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gacela_locataire/views/screens/home/course/course_screen.dart';

import 'package:gacela_locataire/views/widgets/gacela_course.dart';
import '../../widgets.dart';
import '../../../../config/theme/colors.dart';
import '../../../../config/theme/theme.dart';
import '../../../config/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/";
  const HomeScreen({Key? key}) : super(key: key);

  get fontFamily => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Courses",
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: Column(
            children: [
              gacelaButton(
                  onPressed: () async =>
                      Navigator.pushNamed(context, CourseScreen.route),
                  text: "Course screen"),
            ],
          ),
        ),
      ),
    );
  }
}
