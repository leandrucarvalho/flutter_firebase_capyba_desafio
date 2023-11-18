import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserController extends ChangeNotifier {
  final User? user = FirebaseAuth.instance.currentUser;

  UserModel? userModel;
  String? error;
  bool isLoading = false;

  Future<void> loadUserData() async {
    isLoading = true;
    error = null;
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get()
          .then(
        (QuerySnapshot doc) {
          final data = doc.docs.first.data() as Map<String, dynamic>;
          return data;
        },
      );

      userModel = UserModel.fromFirestore(userSnapshot);
      isLoading = false;

      notifyListeners();
    } on FirebaseException catch (e) {
      error = 'Erro ao carregar dados do usuário: ${e.message}';
    } catch (e) {
      error = 'Erro ao carregar dados do usuário: $e';
    }
  }

  Future<String?> updateUserData(UserModel userModel) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get();

      final docs = userSnapshot.docs;
      if (docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docs.first.id)
            .update(userModel.toMap());
      }
      notifyListeners();
      return null;
    } on FirebaseException catch (e) {
      return 'Erro ao atualizar dados do usuário: ${e.message}';
    } catch (e) {
      return 'Erro ao atualizar dados do usuário: $e';
    }
  }

  Future<String?> fetchUserDetails() async {
    if (user != null) {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user!.email)
          .get();
      if (userQuery.docs.isNotEmpty) {
        String name = userQuery.docs[0]['firstname'];
        return name;
      }
      notifyListeners();
    }
    return null;
  }
}
