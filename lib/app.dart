import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'config/routes/routes.dart';
import 'config/theme/theme.dart';
import 'providers/auth_provider.dart';
import 'providers/course_provider.dart';

class GacelaLocataireApp extends StatelessWidget {
  const GacelaLocataireApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gacela',
        theme: GacelaTheme.gacelaTheme,
        routes: Routes.routes,
        initialRoute: "/",
      ),
    );
  }
}
