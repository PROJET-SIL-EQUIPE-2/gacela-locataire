import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/theme/colors.dart';
import '../../../config/theme/theme.dart';
import '../../widgets.dart';

class IntroScreen extends StatefulWidget {
  static const route = "/intro";

  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(
                  height: GacelaTheme.vDivider * 2,
                ),
                Text(
                  'Bienvenue',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'dans GACELA!',
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: GacelaTheme.vDivider * 2,
                ),
                Text(
                  'Le premier service de véhicule autonome sans conducteur en Algérie',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(wordSpacing: 2),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: GacelaTheme.vDivider * 2,
                ),
                gacelaButton(onPressed: () {}, text: 'Connexion'),
                const SizedBox(
                  height: GacelaTheme.vDivider * 3,
                ),
                const Text(
                  'Vous ne possédez pas de compte',
                ),
                gacelaLinkButton(
                    text: 'Inscrivez-vous!',
                    onPressed: () {},
                    color: GacelaColors.gacelaOrange)
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    ));
  }
}
