import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gacela_locataire/config/theme/colors.dart';
import 'package:gacela_locataire/config/theme/theme.dart';
import 'package:gacela_locataire/models/notifier_state.dart';
import 'package:gacela_locataire/models/services/localstorage_service.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/utilities/validation.dart';
import 'package:gacela_locataire/views/screens.dart';
import 'package:gacela_locataire/views/screens/auth/register_screen.dart';
import 'package:gacela_locataire/views/widgets/gacela_widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const route = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = "";
  String _password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void _submit() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await Provider.of<AuthProvider>(context, listen: false)
            .login(_email, _password);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/logo.svg",
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  Text(
                    "Connectez-vous",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 2 * GacelaTheme.vDivider),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: GacelaTheme.hPadding),
                        child: Column(
                          children: [
                            gacelaTextFormField(
                              hintText: "Adresse e-mail",
                              onSaved: (value) {
                                _email = value?.trim() ?? "";
                              },
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => emailValidation(
                                  value, "L'adresse email est erroné"),
                            ),
                            const SizedBox(height: GacelaTheme.vDivider),
                            gacelaTextFormField(
                              hintText: "Mot de passe",
                              onSaved: (value) {
                                _password = value?.trim() ?? "";
                              },
                              obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => notEmptyField(value, 8,
                                  "Le mot de passe doit être +8 caractère"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                gacelaLinkButton(
                                  text: "Mot de passe oublié ?",
                                  onPressed: () async {
                                    Navigator.pushNamed(
                                        context, ResetPasswordScreen.route);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 2 * GacelaTheme.vDivider),
                          ],
                        ),
                      )),
                  Consumer<AuthProvider>(
                    builder: (ctx, authProvider, _) {
                      if (authProvider.state == NotifierState.initial) {
                        return gacelaButton(
                          text: "Connexion",
                          onPressed: _submit,
                        );
                      } else if (authProvider.state == NotifierState.loading) {
                        return const CircularProgressIndicator();
                      } else if (authProvider.failure != null) {
                        return Column(
                          children: [
                            gacelaErrorText(
                                text: authProvider.failure!.message),
                            gacelaButton(
                              text: "Connexion",
                              onPressed: _submit,
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(height: GacelaTheme.vDivider),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                            height: 1, color: GacelaColors.gacelaGrey),
                      ),
                      Text(
                        " Pas de compte ? ",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Flexible(
                        child: Container(
                            height: 1, color: GacelaColors.gacelaGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: GacelaTheme.vDivider),
                  gacelaButton(
                    onPressed: () async {
                      await Navigator.pushReplacementNamed(
                          context, RegisterScreen.route);
                    },
                    text: "Inscription",
                    color: GacelaColors.gacelaOrange,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
