import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/theme.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Current User id = ${auth.user?.id}"),
              Center(
                  child: gacelaButton(
                      text: "Logout",
                      onPressed: () async {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
