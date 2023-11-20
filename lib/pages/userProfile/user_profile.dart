import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/models/user_model.dart';

import '../../controller/user_controller.dart';
import '../../di/di_setup.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

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
    _userController = getIt.get<UserController>();
    fetchUser();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void fetchUser() async {
    await _userController.loadUserData();
    if (_userController.userModel != null) {
      fillControllers(_userController.userModel!);
    }
  }

  void fillControllers(UserModel userModel) {
    _nameController.text = userModel.firstname!;
    _lastNameController.text = userModel.lastname!;
    _emailController.text = userModel.email!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Perfil do Usuário'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                cursorColor: Colors.green,
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                cursorColor: Colors.green,
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Sobrenome',
                  labelStyle: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                cursorColor: Colors.green,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  var userModel = UserModel(
                    firstname: _nameController.text,
                    lastname: _lastNameController.text,
                    email: _emailController.text,
                  );
                  var result = await _userController.updateUserData(userModel);
                  if (result == null) {
                    showMessage("Dados atualizados com sucesso!");
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  } else {
                    showMessage("[ERRO] Os dados não foram atualizados!");
                  }
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    Colors.green,
                  ),
                ),
                child: const Text(
                  'Salvar Alterações',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
