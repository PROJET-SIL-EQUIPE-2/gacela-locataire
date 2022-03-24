import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gacela_locataire/providers/auth_provider.dart';
import 'package:gacela_locataire/views/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  testWidgets('login screen / password', (tester) async {
    await tester.pumpWidget(ChangeNotifierProvider.value(
        value: AuthProvider(),
        child: const MaterialApp(
          home: LoginScreen(),
        )));
    final email = find.widgetWithText(TextFormField, 'Adresse e-mail');
    final password = find.widgetWithText(TextFormField, 'Mot de passe');
    final button = find.widgetWithText(GestureDetector, 'Connexion');
    await tester.enterText(email, 'in_fatmi@esi.dz');
    await tester.enterText(password, 'resetreset');
    await tester.tap(button);
    await tester.pump();
    final icon = find.byIcon(Icons.error_outline);
    expect(icon, findsOneWidget);
  });
}
