import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/colors.dart';
import '../../../config/theme/theme.dart';
import '../../../models/notifier_state.dart';
import '../../../providers/auth_provider.dart';
import '../../widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const route = "/reset-password";

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String _email = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: GacelaColors.gacelaBlue,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: GacelaTheme.hPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/logo.svg',
                height: MediaQuery.of(context).size.width * 0.4,
              ),
              const SizedBox(
                height: GacelaTheme.vDivider * 3,
              ),
              Text(
                'Changer votre mot de passe',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(
                height: GacelaTheme.vDivider * 2,
              ),
              gacelaTextField(
                hintText: 'Adresse e-mail',
                onChanged: (value) {
                  _email = value?.trim() ?? "";
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: GacelaTheme.vDivider * 2,
              ),
              Consumer<AuthProvider>(
                builder: (ctx, authProvider, _) {
                  final Widget resetBtn = gacelaButton(
                      onPressed: () async {
                        await authProvider.resetPassword(_email);
                      },
                      text: 'Envoyer');
                  if (authProvider.state == NotifierState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (authProvider.message != null) {
                    Future.delayed(Duration.zero, () {
                      authProvider.setProviderState(NotifierState.initial);
                    });
                    return Column(
                      children: [
                        gacelaSuccessText(text: authProvider.message!),
                        resetBtn,
                      ],
                    );
                  } else if (authProvider.failure != null) {
                    return Column(
                      children: [
                        gacelaErrorText(text: authProvider.failure!.message),
                        resetBtn,
                      ],
                    );
                  } else {
                    return resetBtn;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
