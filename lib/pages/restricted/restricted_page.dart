import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/controller/restricted_controller.dart';
// Importe o modelo HomeModel
import 'package:flutter_firebase_capyba_desafio/models/restricted_model.dart';

import '../../di/di_setup.dart';

class RestrictedPage extends StatefulWidget {
  const RestrictedPage({Key? key}) : super(key: key);

  @override
  State<RestrictedPage> createState() => RestrictedPageState();
}

class RestrictedPageState extends State<RestrictedPage> {
  late RestrictedController _restrictedController;

  @override
  void initState() {
    super.initState();
    _restrictedController = getIt.get<RestrictedController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<RestrictedModel>>(
        future: _restrictedController.fetchRestrictedData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
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
    );
  }
}
