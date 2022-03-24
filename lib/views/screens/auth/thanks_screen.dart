import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/theme/theme.dart';
import '../../../models/notifier_state.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets.dart';
import '../../screens.dart';

class ThanksScreen extends StatelessWidget {
  static const route = "/thanks";
  const ThanksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/icons/logo.svg",
              width: MediaQuery.of(context).size.width * 0.4),
          const SizedBox(height: GacelaTheme.vDivider),
          Text("Merci", style: Theme.of(context).textTheme.headline1),
          const SizedBox(height: GacelaTheme.vDivider),
          const Flexible(
              child: Text("Votre compte sera validé dans quelque heurs")),
          const SizedBox(height: GacelaTheme.vDivider),
          gacelaButton(
              text: "Connectez-vous",
              onPressed: () async {
                Provider.of<AuthProvider>(context, listen: false)
                    .clearMessage();
                Provider.of<AuthProvider>(context, listen: false)
                    .setProviderState(NotifierState.initial);
                await Navigator.pushReplacementNamed(
                    context, LoginScreen.route);
              })
        ],
      ),
    ));
  }
}
