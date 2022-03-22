import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/views/screens/auth/login_screen.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';

class RegisterScreen extends StatefulWidget {
  static const route = "/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Widget _firstPage = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Inscrivez-vous",
          style: Theme.of(context).textTheme.headline2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: Column(
            children: [
              gacelaCircleButton(
                radius: 80,
                onPressed: () {},
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                ),
              ),
              const SizedBox(height: 2 * GacelaTheme.vDivider),
              Row(
                children: [
                  Flexible(child: gacelaTextFormField(hintText: "Nom")),
                  const SizedBox(width: GacelaTheme.hPadding),
                  Flexible(child: gacelaTextFormField(hintText: "Prenom")),
                ],
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaTextFormField(hintText: "Adresse e-mail"),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaTextFormField(
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaTextFormField(
                hintText: "Confirmation mot de passe",
                obscureText: true,
              ),
            ],
          ),
        ),
        Column(
          children: [
            gacelaButton(
              onPressed: () {
                setState(() => _currentIndex++);
              },
              text: "Suivant",
              icon: const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: GacelaTheme.vDivider),
            const Text("Vous avez un compte ?"),
            gacelaLinkButton(
                text: "Connectez-vous !",
                onPressed: () async {
                  Navigator.pushReplacementNamed(context, LoginScreen.route);
                })
          ],
        ),
      ],
    );
    final Widget _secondPage = Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset("assets/icons/logo.svg",
            width: MediaQuery.of(context).size.width * 0.3),
        Text(
          "Encore une étape pour compléter votre inscription",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        Column(
          children: [
            gacelaCircleButton(
              onPressed: () {},
              radius: 95,
              child: const Icon(
                Icons.camera_alt_outlined,
                size: 40,
                color: GacelaColors.gacelaGrey,
              ),
            ),
            const SizedBox(height: 4 * GacelaTheme.vDivider),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'ajoutez une photo de votre\n',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  TextSpan(
                    text: 'carte d\'identité',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: GacelaColors.gacelaRed),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                gacelaTextButton(
                  text: "Back",
                  onPressed: () {
                    setState(() => _currentIndex--);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: GacelaColors.gacelaDeepBlue,
                  ),
                ),
                gacelaTextButton(
                  text: "Valider",
                  onPressed: () {},
                  icon: const Icon(
                    Icons.check,
                    color: GacelaColors.gacelaDeepBlue,
                    size: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Form(
                child: _currentIndex == 0 ? _firstPage : _secondPage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
