import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: GacelaTheme.hPadding,
            vertical: GacelaTheme.vDivider,
          ),
          child: gacelaCard(
              color: Colors.transparent,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    minVerticalPadding: GacelaTheme.vDivider,
                    leading: const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          NetworkImage("https://i.pravatar.cc/300"),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: GacelaColors.gacelaOrange,
                        ),
                        Text("Mettre à jour la photo")
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
                            labelText: "Nom",
                            enabled: false,
                            initialValue: "John",
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: gacelaTextField(
                            labelText: "Prénom",
                            enabled: false,
                            initialValue: "Doe",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: GacelaTheme.vDivider),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GacelaTheme.hPadding),
                    child: gacelaTextField(
                      labelText: "Adresse e-mail",
                      enabled: false,
                      initialValue: "useremail@email.com",
                    ),
                  ),
                  const SizedBox(height: GacelaTheme.vDivider),
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
                          ),
                          const SizedBox(height: GacelaTheme.vDivider),
                          gacelaTextField(
                            labelText: "Confirmer mot de passe",
                            hintText: "Confirmer mot de passe",
                            enabled: _modifyPassword,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: GacelaTheme.vDivider),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: GacelaTheme.hPadding),
                    child: gacelaButton(
                      onPressed: () {},
                      text: "Valider",
                      color: GacelaColors.gacelaOrange,
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
