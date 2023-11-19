import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/pages/homeView/home_view_page.dart';
import 'package:flutter_firebase_capyba_desafio/pages/login/login_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePageView();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
