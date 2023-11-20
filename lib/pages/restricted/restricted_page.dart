import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/controller/restricted_controller.dart';
import 'package:flutter_firebase_capyba_desafio/models/restricted_model.dart';
// Importe o modelo HomeModel
import 'package:flutter_firebase_capyba_desafio/state/auth_state.dart';

import '../../controller/login_controller.dart';
import '../../di/di_setup.dart';

class RestrictedPage extends StatefulWidget {
  const RestrictedPage({Key? key}) : super(key: key);

  @override
  State<RestrictedPage> createState() => RestrictedPageState();
}

class RestrictedPageState extends State<RestrictedPage> {
  late RestrictedController _restrictedController;
  late LoginController _authService;

  @override
  void initState() {
    super.initState();
    _restrictedController = getIt.get<RestrictedController>();
    _authService = getIt.get<LoginController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _authService.state,
        builder: (_, state, __) {
          return switch (state) {
            AuthLoading() || AuthError() || AuthInitial() => const Center(
                child: SizedBox.shrink(),
              ),
            AuthData(user: var user) => !user.emailConfirmed
                ? const Text('Error aqui ')
                : FutureBuilder<List<RestrictedModel>>(
                    future: _restrictedController.fetchRestrictedData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Erro: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Nenhum dado encontrado.'),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            RestrictedModel data = snapshot.data![index];
                            return ListTile(
                              title: Text(
                                'Documento ${index + 1}',
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Campo 1: ${data.campo1}'),
                                  Text('Campo 2: ${data.campo2}'),
                                  Text('Campo 3: ${data.campo3}'),
                                  // Adicione mais linhas conforme necessário
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
          };
        },
      ),
    );
  }
}
