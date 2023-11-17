import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final User? _user = FirebaseAuth.instance.currentUser;

  User? get user => _user;

  Future<String?> loadUserData(
      TextEditingController nameController,
      TextEditingController lastNameController,
      TextEditingController emailController) async {
    try {
      // Obtenha uma referência ao documento do usuário no Firestore
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _user!.email)
          .get();

      final docs = userSnapshot.docs;
      if (docs.isNotEmpty) {
        final data = docs.first.data() as Map<String, dynamic>;
        nameController.text = data['firstname'] ?? '';
        lastNameController.text = data['lastname'] ?? '';
        emailController.text = data['email'] ?? '';
      }
    } on FirebaseException catch (e) {
      return 'Erro ao carregar dados do usuário: ${e.message}';
    } catch (e) {
      return 'Erro ao carregar dados do usuário: $e';
    }
    return null;
  }

  Future<String?> updateUserData(
      TextEditingController nameController,
      TextEditingController lastNameController,
      TextEditingController emailController) async {
    try {
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _user!.email)
          .get();

      final docs = userSnapshot.docs;

      // Atualize os dados do usuário no Firestore
      if (docs.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(docs.first.id)
            .update({
          'firstname': nameController.text,
          'lastname': lastNameController.text,
          'email': emailController.text,
        });
      }

      return null;
    } on FirebaseException catch (e) {
      return 'Erro ao atualizar dados do usuário: ${e.message}';
    } catch (e) {
      return 'Erro ao atualizar dados do usuário: $e';
    }
  }

  Future<String?> fetchUserDetails() async {
    if (_user != null) {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _user!.email)
          .get();
      if (userQuery.docs.isNotEmpty) {
        String name = userQuery.docs[0]['firstname'];
        return name;
      }
    }
    return null;
  }
}
