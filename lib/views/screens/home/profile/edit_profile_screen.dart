import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gacela_locataire/models/errors/failure.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:gacela_locataire/providers/profile_provider.dart';
import 'package:gacela_locataire/utilities/validation.dart';
import '../../../../config/theme/colors.dart';
import '../../../../config/theme/theme.dart';
import '../../../widgets.dart';

class EditProfileScreen extends StatefulWidget {
  static const route = "/profile/edit";
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _modifyPassword = false;

  // loading
  bool isLoading = false;

  // error message
  String? errorMessage;

  // success message
  String? successMessage;

  // password variables
  String? oldPassword = "";
  String? newPassword = "";
  String? newPasswordConfirm = "";

  // email
  String? newEmail;

  // form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  // ignore: unused_element
  _submit() async {
    ProfileProvider profileProvider = ProfileProvider(
      locataire: Provider.of<AuthProvider>(context, listen: false).user!,
      token: Provider.of<AuthProvider>(context, listen: false).token!,
    );
    // change password case
    if (_modifyPassword) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (newPassword == newPasswordConfirm) {
          // change The Password
          setState(() => isLoading = true);
          try {
            Map<String, dynamic> result =
                await profileProvider.changePassword(oldPassword, newPassword);
            setState(() {
              successMessage = result["msg"];
              errorMessage = null;
              isLoading = false;
              _modifyPassword = false;
            });
          } on Failure catch (f) {
            setState(() {
              errorMessage = f.message;
              errorMessage = null;
              isLoading = false;
            });
          }
        } else {
          setState(() => errorMessage = "Reconfirmer votre mot de passe");
        }
      }
    }
  }

  // ignore: unused_element
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Changer votre email'),
          content: Form(
            key: _emailFormKey,
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  gacelaTextField(
                    labelText: "Adresse e-mail",
                    onChanged: (value) => newEmail = value,
                    validator: (value) =>
                        emailValidation(value, "Email incorrecte"),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Retour',
                style: TextStyle(color: GacelaColors.gacelaRed),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confimer'),
              onPressed: () async {
                ProfileProvider profileProvider = ProfileProvider(
                  locataire:
                      Provider.of<AuthProvider>(context, listen: false).user!,
                  token:
                      Provider.of<AuthProvider>(context, listen: false).token!,
                );

                // change email
                if (_emailFormKey.currentState!.validate()) {
                  _emailFormKey.currentState!.save();

                  try {
                    Map<String, dynamic> result =
                        await profileProvider.changeEmail(newEmail);
                    if (result["success"]) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result["msg"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: GacelaColors.gacelaGreen,
                        ),
                      );
                    }
                  } on Failure catch (f) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          f.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: GacelaColors.gacelaRed,
                      ),
                    );
                  }
                } else {
                  setState(() {
                    errorMessage = "Le nouveau email est incorrecte";
                  });
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Modifiez vos info",
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (_, auth, __) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: GacelaTheme.hPadding,
              vertical: GacelaTheme.vDivider,
            ),
            child: gacelaCard(
                color: GacelaColors.gacelaLightPurple,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: GacelaTheme.vPadding),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        onBackgroundImageError: (_, __) =>
                            Image.asset('assets/images/placeholder-image.png'),
                        backgroundImage: NetworkImage(
                          "${dotenv.get("SERVER")}/${(Provider.of<AuthProvider>(context, listen: false).user?.personalPhoto as String).replaceAll('\\', '/')}.png",
                        ),
                      ),
                    ),
                    const Divider(height: 1, color: GacelaColors.gacelaPurple),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GacelaTheme.hPadding),
                      child: Row(
                        children: [
                          Flexible(
                            child: gacelaTextField(
                              labelText: "Nom",
                              enabled: false,
                              initialValue: auth.user?.familyName,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: gacelaTextField(
                              labelText: "Prénom",
                              enabled: false,
                              initialValue: auth.user?.name,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: GacelaTheme.vDivider),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GacelaTheme.hPadding),
                      child: Row(
                        children: [
                          Flexible(
                            child: gacelaTextField(
                              labelText: "Adresse e-mail",
                              enabled: false,
                              onChanged: (value) => newEmail = value,
                              validator: (value) =>
                                  emailValidation(value, "Email incorrecte"),
                              initialValue: auth.user?.email,
                            ),
                          ),
                          IconButton(
                            onPressed: _showMyDialog,
                            icon: const Icon(
                              Icons.edit,
                              color: GacelaColors.gacelaOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: GacelaTheme.vDivider),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: GacelaTheme.hPadding),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: gacelaTextField(
                                    labelText: _modifyPassword
                                        ? "Ancien Mot de passe"
                                        : "Mot de passe",
                                    enabled: _modifyPassword,
                                    initialValue:
                                        _modifyPassword ? null : "placeholder",
                                    obscureText: true,
                                    onSaved: (value) => oldPassword = value,
                                    validator: (value) => notEmptyField(
                                        value,
                                        8,
                                        "Le mot de passe doit être +8 caractère"),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => setState(
                                      () => _modifyPassword = !_modifyPassword),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: GacelaColors.gacelaOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_modifyPassword)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: GacelaTheme.hPadding),
                              child: Column(
                                children: [
                                  const SizedBox(height: GacelaTheme.vDivider),
                                  gacelaTextField(
                                      labelText: "Nouveau mot de passe",
                                      hintText: "Nouveau mot de passe",
                                      enabled: _modifyPassword,
                                      obscureText: true,
                                      onSaved: (value) => newPassword = value,
                                      validator: (value) => notEmptyField(
                                          value,
                                          8,
                                          "Le mot de passe doit être +8 caractère")),
                                  const SizedBox(height: GacelaTheme.vDivider),
                                  gacelaTextField(
                                      labelText: "Confirmer mot de passe",
                                      hintText: "Confirmer mot de passe",
                                      enabled: _modifyPassword,
                                      obscureText: true,
                                      onSaved: (value) =>
                                          newPasswordConfirm = value,
                                      validator: (value) => notEmptyField(
                                          value,
                                          8,
                                          "Le mot de passe doit être +8 caractère")),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: GacelaTheme.vDivider),
                    if (errorMessage != null)
                      Center(
                        child: Text(errorMessage!,
                            style: const TextStyle(
                                color: GacelaColors.gacelaRed,
                                fontWeight: FontWeight.w500)),
                      ),
                    if (successMessage != null)
                      Center(
                        child: Text(successMessage!,
                            style: const TextStyle(
                                color: GacelaColors.gacelaGreen,
                                fontWeight: FontWeight.w500)),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: GacelaTheme.hPadding),
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : gacelaButton(
                              onPressed: _submit,
                              text: "Valider",
                              color: GacelaColors.gacelaPurple,
                            ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
