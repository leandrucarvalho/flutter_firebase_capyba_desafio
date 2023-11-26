import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/controller/home_controller.dart';
import 'package:flutter_firebase_capyba_desafio/models/home_model.dart';

import '../../di/di_setup.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = getIt.get<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<HomeModel>>(
        future: _homeController.fetchHomeData(),
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
                HomeModel data = snapshot.data![index];
                return ListTile(
                  title: Text(
                    'Documento ${index + 1}',
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Nome: ${data.nome}'),
                      Text('Idade: ${data.idade}'),
                      Text('Cidade: ${data.cidade}'),
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
