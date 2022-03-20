import 'package:flutter/material.dart';
import 'package:gacela_locataire/models/notifier_state.dart';
import '../../../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets.dart';

class LoginScreen extends StatelessWidget {
  static const route = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<AuthProvider>(
          builder: (ctx, authProvider, _) {
            if (authProvider.state == NotifierState.initial) {
              return gacelaButton(
                child: const Text("Login"),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .login("in_fatmi@esi.dz", "12345678");
                },
              );
            } else if (authProvider.state == NotifierState.loading) {
              return const CircularProgressIndicator();
            } else if (authProvider.failure != null) {
              return Text(
                authProvider.failure!.message,
                style: const TextStyle(color: Colors.red),
              );
            } else {
              return Text(authProvider.user?.email ?? "none");
            }
          },
        ),
      ),
    );
  }
}
