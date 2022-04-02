import 'package:flutter/material.dart';
import 'transactions_screen.dart';

class TransactionsNavigator extends StatelessWidget {
  static final GlobalKey<NavigatorState> transactionsNavigatorKey =
      GlobalKey<NavigatorState>();
  const TransactionsNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: TransactionsNavigator.transactionsNavigatorKey,
      initialRoute: TransactionsScreen.route,
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
        switch (settings.name) {
          case TransactionsScreen.route:
            return const TransactionsScreen();
          default:
            return const TransactionsScreen();
        }
      }),
    );
  }
}
