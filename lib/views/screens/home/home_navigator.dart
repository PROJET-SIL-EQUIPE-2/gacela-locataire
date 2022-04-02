import 'package:flutter/material.dart';
import 'home_screen.dart';

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
          default:
            return const HomeScreen();
        }
      }),
    );
  }
}
