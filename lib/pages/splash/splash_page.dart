import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/controller/login_controller.dart';
import 'package:flutter_firebase_capyba_desafio/di/di_setup.dart';
import 'package:flutter_firebase_capyba_desafio/state/auth_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late LoginController _authService;

  @override
  void initState() {
    super.initState();
    _authService = getIt.get<LoginController>();
    checkAuthState();
  }

  void checkAuthState() async {
    await _authService.fetchUserDetails();
    if (_authService.state.value is AuthData && context.mounted) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );
  }
}
