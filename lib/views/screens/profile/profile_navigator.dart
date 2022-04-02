import 'package:flutter/material.dart';
import 'profile_screen.dart';

class ProfileNavigator extends StatelessWidget {
  static final GlobalKey<NavigatorState> profileNavigatorKey =
      GlobalKey<NavigatorState>();
  const ProfileNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: ProfileNavigator.profileNavigatorKey,
      initialRoute: ProfileScreen.route,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) {
          switch (settings.name) {
            case ProfileScreen.route:
              return const ProfileScreen();
            default:
              return const ProfileScreen();
          }
        },
      ),
    );
  }
}
