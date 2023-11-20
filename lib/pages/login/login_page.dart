import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/login_controller.dart';
import '../../di/di_setup.dart';
import '../../state/auth_state.dart';
import '../../widgets/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  static final _formKey = GlobalKey<FormState>();
  late LoginController loginController;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    loginController = getIt.get<LoginController>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> setIsLoading() async {
    setState(() {
      isLoading = true;
    });
  }

  void showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: loginController.state,
        builder: (context, state, child) {
          switch (state) {
            case AuthData():
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, "/home");
              });
            case AuthError(error: var error):
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showErrorMessage(error);
              });
              break;
            default:
              break;
          }
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.fire,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Olá Novamente!',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: _emailController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Senha',
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe sua senha';
                              } else if (value.length < 6) {
                                return 'Sua senha deve ter no mínimo 6 caracteres';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const ForgotPassword(),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: InkWell(
                          onTap: () {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              showErrorMessage("Preencha todos os campos");
                            } else {
                              loginController.signIn(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
                          },
                          child: Ink(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Ou',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Ainda não é um membro?',
                            ),
                            Text(
                              ' Cadastre-se agora!',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
