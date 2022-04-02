import 'package:flutter/material.dart';
import 'support_screen.dart';

class SupportNavigator extends StatelessWidget {
  static final GlobalKey<NavigatorState> supportNavigatorKey =
      GlobalKey<NavigatorState>();
  const SupportNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: SupportNavigator.supportNavigatorKey,
      initialRoute: SupportScreen.route,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case SupportScreen.route:
            return const SupportScreen();
          default:
            return const SupportScreen();
        }
      }),
    );
  }
}
