import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/login_controller.dart';
import '../di/di_setup.dart';
import '../state/auth_state.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = getIt.get<LoginController>();
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder(
            valueListenable: loginController.state,
            builder: (context, state, _) {
              return switch (state) {
                AuthInitial() || AuthLoading() => const Text("Carregando..."),
                AuthError() => const Text("Erro ao carregar os dados"),
                AuthData(user: var user) => UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(Icons.person_2),
                    ),
                    accountName: Text('${user.firstname}'),
                    accountEmail: Text('${user.email}'),
                  ),
              };
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/userprofile',
                );
              },
              child: const Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidUser,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Meu Perfil"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  '/confirmEmail',
                );
              },
              child: const Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidEnvelope,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Validar Email"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.arrowRightFromBracket,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Sair"),
                ],
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Capyba flutter app"),
                    content: const Text("Deseja realmente sair do app?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Não",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);

                          loginController.signOut();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Sim",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
