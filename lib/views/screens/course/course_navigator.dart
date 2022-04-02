import 'package:flutter/material.dart';
import 'course_screen.dart';

class CourseNavigator extends StatelessWidget {
  static final GlobalKey<NavigatorState> courseNavigatorKey =
      GlobalKey<NavigatorState>();
  const CourseNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: CourseNavigator.courseNavigatorKey,
      initialRoute: CourseScreen.route,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case CourseScreen.route:
            return const CourseScreen();
          default:
            return const CourseScreen();
        }
      }),
    );
  }
}
