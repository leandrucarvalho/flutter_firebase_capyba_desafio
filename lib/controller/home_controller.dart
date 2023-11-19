import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/models/home_model.dart';

class HomeController extends ChangeNotifier {
  HomeModel? homeModel;
  List<HomeModel> homeModelList = [];
  String? error;
  bool isLoading = false;

  Future<List<HomeModel>> fetchHomeData() async {
    isLoading = true;
    error = null;

    try {
      final QuerySnapshot<Map<String, dynamic>> homeSnapshot =
          await FirebaseFirestore.instance.collection('home').get();

      final List<HomeModel> homeList = homeSnapshot.docs.map((doc) {
        final data = doc.data();
        return HomeModel.fromFirestore(data);
      }).toList();

      homeModelList = homeList;
      isLoading = false;

      notifyListeners();
      return homeModelList;
    } on FirebaseException catch (e) {
      error = 'Erro ao carregar dados da home page: ${e.message}';
    } catch (e) {
      error = 'Erro ao carregar dados da home page: $e';
    }
    return [];
  }
}
