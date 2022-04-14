import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'profile/edit_profile_screen.dart';
import 'home_screen.dart';
import 'home_screen_details.dart';
import 'profile/profile_screen.dart';
import 'course/course_screen.dart';

class HomeNavigator extends StatelessWidget {
  static final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: HomeNavigator.homeNavigatorKey,
      initialRoute: HomeScreen.route,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case HomeScreen.route:
            return const HomeScreen(); 
         /*  case HomeScreenDetails.route:
             return const HomeScreenDetails();   */      
         case ProfileScreen.route:
            return const ProfileScreen();
          case EditProfileScreen.route:
            return const EditProfileScreen();
          case NotificationsScreen.route:
            return const NotificationsScreen();
          case CourseScreen.route:
            return const CourseScreen();
          default:
            return const HomeScreen();
        }
      }),
    );
  }
}
