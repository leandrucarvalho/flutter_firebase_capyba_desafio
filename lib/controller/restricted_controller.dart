import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/models/restricted_model.dart';

class RestrictedController extends ChangeNotifier {
  RestrictedModel? restrictedModel;
  List<RestrictedModel> restrictedModelList = [];
  String? error;
  bool isLoading = false;

  Future<List<RestrictedModel>> fetchRestrictedData() async {
    isLoading = true;
    error = null;

    try {
      final QuerySnapshot<Map<String, dynamic>> restrictedSnapshot =
          await FirebaseFirestore.instance.collection('restricted').get();

      final List<RestrictedModel> restrictedList =
          restrictedSnapshot.docs.map((doc) {
        final data = doc.data();
        return RestrictedModel.fromFirestore(data);
      }).toList();

      restrictedModelList = restrictedList;
      isLoading = false;

      notifyListeners();
      return restrictedModelList;
    } on FirebaseException catch (e) {
      error = 'Erro ao carregar dados da home page: ${e.message}';
    } catch (e) {
      error = 'Erro ao carregar dados da home page: $e';
    }
    return [];
  }
}
