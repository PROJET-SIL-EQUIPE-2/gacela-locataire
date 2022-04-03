import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gacela_locataire/views/screens/wrapper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/colors.dart';
import '../../../config/theme/theme.dart';
import '../../../models/notifier_state.dart';
import '../../../providers/auth_provider.dart';
import '../../../utilities/validation.dart';
import '../../screens.dart';
import '../../widgets.dart';
import '../../../models/locataire.dart';

class RegisterScreen extends StatefulWidget {
  static const route = "/register";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentIndex = 0;
  Locataire _locataire = Locataire();
  String _password = "", _passwordConfirm = "";
  bool _isError = false;
  String? _errorMessage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _validateForm() {
    if (_formKey.currentState!.validate() && _locataire.personalPhoto != null) {
      _formKey.currentState!.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _submit() async {
      if (_formKey.currentState!.validate()) {
        if (_locataire.photoIdentity == null ||
            _locataire.personalPhoto == null) return;
        _formKey.currentState!.save();
        final bool? success =
            await Provider.of<AuthProvider>(context, listen: false)
                .register(_locataire, _password);
        if (success != null && success) {
          await Navigator.pushReplacementNamed(context, ThanksScreen.route);
        }
      }
    }

    Widget _firstPage = Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  gacelaCircleButton(
                    radius: 80,
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      try {
                        final XFile? file = await _picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 50);

                        if (file != null) {
                          _locataire.personalPhoto = file;
                          setState(() {});
                        }
                      } catch (e) {
                        setState(() {
                          _errorMessage =
                              "il faut prendre un selfie pour continuer";
                          _isError = true;
                        });
                      }
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 30,
                    ),
                  ),
                  if (_locataire.personalPhoto != null)
                    const SizedBox(width: 10),
                  if (_locataire.personalPhoto != null)
                    Container(
                      width: 40,
                      height: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.file(
                        File(_locataire.personalPhoto.path),
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    )
                ],
              ),
              const SizedBox(height: 2 * GacelaTheme.vDivider),
              Row(
                children: [
                  Flexible(
                    child: gacelaTextFormField(
                      value: _locataire.familyName,
                      hintText: "Nom",
                      onSaved: (value) => _locataire.name = value?.trim(),
                      validator: (value) =>
                          notEmptyField(value, 3, "Nom doit être +3 caracters"),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(width: GacelaTheme.hPadding),
                  Flexible(
                    child: gacelaTextFormField(
                      value: _locataire.name,
                      hintText: "Prenom",
                      onSaved: (value) => _locataire.familyName = value?.trim(),
                      validator: (value) => notEmptyField(
                          value, 3, "Prenom doit être +3 caracters"),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaTextFormField(
                value: _locataire.email,
                hintText: "Adresse e-mail",
                onSaved: (value) => _locataire.email = value?.trim(),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    emailValidation(value, "L'adresse email est erroné"),
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/dz.svg", width: 18),
                  const Text("+213 ",
                      style: TextStyle(color: GacelaColors.gacelaGrey)),
                  Flexible(
                    child: gacelaTextFormField(
                        value: _locataire.phoneNumber,
                        hintText: " Numéro de téléphone",
                        onSaved: (value) =>
                            _locataire.phoneNumber = value?.trim(),
                        keyboardType: TextInputType.phone,
                        validator: (value) => notEmptyField(
                            value, 9, "Le numero de téléphone est invalide")),
                  ),
                ],
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaTextFormField(
                hintText: "Password",
                value: _password,
                obscureText: true,
                onChanged: (value) => _password = value?.trim() ?? "",
                keyboardType: TextInputType.emailAddress,
                validator: (value) => notEmptyField(
                    value, 8, "Le mot de passe doit être +8 caractère"),
              ),
              const SizedBox(height: GacelaTheme.vDivider),
              gacelaTextFormField(
                value: _passwordConfirm,
                hintText: "Confirmation mot de passe",
                obscureText: true,
                onChanged: (value) => _passwordConfirm = value?.trim() ?? "",
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    _password == value ? null : "Mot de passe incorrecte",
              ),
            ],
          ),
        ),
        Column(
          children: [
            if (_isError && _currentIndex == 0)
              gacelaErrorText(text: _errorMessage!),
            gacelaButton(
              onPressed: () {
                if (_validateForm()) {
                  setState(() {
                    _errorMessage = null;
                    _isError = false;
                    _currentIndex++;
                  });
                } else {
                  setState(() {
                    _errorMessage = "Il faut prendre un selfie pour continuer";
                    _isError = true;
                  });
                }
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
                  Navigator.pushReplacementNamed(context, Wrapper.route);
                })
          ],
        ),
      ],
    );
    Widget _secondPage = Column(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                gacelaCircleButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    try {
                      var file = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 50);

                      if (file != null) {
                        _locataire.photoIdentity = file;
                        setState(() {});
                      }
                    } catch (e) {
                      setState(() {
                        _errorMessage =
                            "Il faut prendre une photo de la carte d'identité";
                        _isError = true;
                      });
                    }
                  },
                  radius: 95,
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                    color: GacelaColors.gacelaGrey,
                  ),
                ),
                if (_locataire.photoIdentity != null) const SizedBox(width: 10),
                if (_locataire.photoIdentity != null)
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.file(
                      File(_locataire.photoIdentity.path),
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  )
              ],
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
            if (_isError && _currentIndex == 1)
              gacelaErrorText(text: _errorMessage!),
            Consumer<AuthProvider>(builder: (ctx, authProvider, _) {
              final actionBtns = Row(
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
                    onPressed: _submit,
                    icon: const Icon(
                      Icons.check,
                      color: GacelaColors.gacelaDeepBlue,
                      size: 25,
                    ),
                  ),
                ],
              );
              if (authProvider.state == NotifierState.initial) {
                return actionBtns;
              } else if (authProvider.state == NotifierState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (authProvider.failure != null) {
                return Column(
                  children: [
                    gacelaErrorText(text: authProvider.failure.toString()),
                    actionBtns,
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
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
                key: _formKey,
                child: _currentIndex == 0 ? _firstPage : _secondPage,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
