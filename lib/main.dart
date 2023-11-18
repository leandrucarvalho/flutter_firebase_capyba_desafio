import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_capyba_desafio/di/di_setup.dart';
import 'package:flutter_firebase_capyba_desafio/pages/home/home_page.dart';
import 'package:flutter_firebase_capyba_desafio/pages/login/login_page.dart';
import 'package:flutter_firebase_capyba_desafio/pages/main_page.dart';
import 'firebase_options.dart';
import 'pages/confirmEmail/confirm_email_page.dart';
import 'pages/register/register_page.dart';
import 'pages/userProfile/user_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
        '/userprofile': (context) => const UserProfilePage(
              userId: '',
            ),
        '/confirmEmail': (context) => const EmailConfirmationPage(
              email: '',
            ),
      },
    );
  }
}
