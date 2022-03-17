import 'package:flutter/material.dart';
import 'package:gacela_locataire/config/routes/routes.dart';
import 'package:gacela_locataire/config/theme/theme.dart';

class GacelaLocataireApp extends StatelessWidget {
  const GacelaLocataireApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gacela',
      theme: GacelaTheme.gacelaTheme,
      routes: Routes.routes,
      initialRoute: "/",
    );
  }
}
