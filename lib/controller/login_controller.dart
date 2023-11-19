import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'user-not-found') {
        return 'Email incorreto ou usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        return 'Senha incorreta';
      } else {
        return 'Erro desconhecido: ${e.message}';
      }
    }
  }

  Future<Map<String, dynamic>?> signUp(
      {required String email, required String password}) async {
    if (passwordConfirmed(
        password: password, confirmpasswordcontroller: password)) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return {'error': 'A senha fornecida é muito fraca.'};
        } else if (e.code == 'email-already-in-use') {
          return {'error': 'A conta já existe para esse e-mail.'};
        } else {
          return {'error': 'Erro desconhecido ao criar usuário: ${e.message}'};
        }
      }
    }
    return {'email': email};
  }

  Future<String?> addUserDetails(
      String firstName, String lastName, String email) async {
    await FirebaseFirestore.instance.collection("users").add(
      {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
        'emailConfirmed': false,
      },
    );
    return null;
  }

  bool passwordConfirmed(
      {required String password, required String confirmpasswordcontroller}) {
    return password.trim() == confirmpasswordcontroller.trim();
  }

  Future<String?> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return null;
    } on FirebaseAuthException catch (ex) {
      return "${ex.code}: ${ex.message}";
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
    }
    return null;
  }
}
