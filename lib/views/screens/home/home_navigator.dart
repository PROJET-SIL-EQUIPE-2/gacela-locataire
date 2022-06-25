import 'package:flutter/material.dart';
import 'package:gacela_locataire/providers/course_provider.dart';
import 'package:gacela_locataire/views/screens/home/course/track_car_screen.dart';
import 'package:gacela_locataire/views/screens/home/search_screen.dart';
import 'package:gacela_locataire/views/screens/home/select_car_screen.dart';
import 'package:gacela_locataire/views/screens/home/support/support_screen.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/car_data_collector.dart';
import 'notifications_screen.dart';
import 'profile/edit_profile_screen.dart';
import 'home_screen.dart';
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
          case SearchScreen.route:
            return const SearchScreen();
          case SelectCarScreen.route:
            return const SelectCarScreen();
          case ProfileScreen.route:
            return const ProfileScreen();
          case EditProfileScreen.route:
            return const EditProfileScreen();
          case NotificationsScreen.route:
            return const NotificationsScreen();
          case CourseScreen.route:
            return const CourseScreen();
          case TrackCarScreen.route:
            return const TrackCarScreen();
          case SupportScreen.route:
            return const SupportScreen();
          default:
            return const HomeScreen();
        }
      }),
    );
  }
}
