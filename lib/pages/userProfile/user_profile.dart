import 'package:flutter/material.dart';

import '../../controller/user_controller.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({super.key, required this.userId});

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late UserController _userController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _userController = UserController();

    _userController.loadUserData(
        _nameController, _lastNameController, _emailController);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Sobrenome'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                var result = await _userController.updateUserData(
                    _nameController, _lastNameController, _emailController);
                if (result == null) {
                  _userController.updateUserData(
                      _nameController, _lastNameController, _emailController);
                  showMessage("Dados atualizados com sucesso!");
                  if (mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  showMessage("[ERRO] Os dados não foram atualizados!");
                }
              },
              child: const Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
