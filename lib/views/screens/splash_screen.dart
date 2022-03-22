import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gacela_locataire/config/theme/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset("assets/icons/logo.svg"),
            const CircularProgressIndicator(
              color: GacelaColors.gacelaBlue,
              backgroundColor: GacelaColors.gacelaGrey,
            ),
          ],
        ),
      ),
    );
  }
}
