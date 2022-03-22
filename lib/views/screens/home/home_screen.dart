import 'package:flutter/material.dart';
import 'package:gacela_locataire/models/services/localstorage_service.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/views/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const route = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: gacelaButton(
                  text: "Logout",
                  onPressed: () async {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logout();
                  })),
        ],
      ),
    );
  }
}
