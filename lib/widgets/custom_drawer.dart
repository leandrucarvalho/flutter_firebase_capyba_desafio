import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/login_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = AuthService();
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.person_2),
            ),
            accountName: FutureBuilder<String?>(
              future: loginController.fetchUserDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  }
                }
                return const Text("Carregando...");
              },
            ),
            accountEmail: Text('${user?.email}'),
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
                    title: const Text("Trilha Flutter"),
                    content: const Text("Deseja realmente sair do app?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Não"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          loginController.signOut();
                        },
                        child: const Text("Sim"),
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
