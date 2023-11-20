import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_capyba_desafio/models/user_model.dart';

import '../state/auth_state.dart';

class LoginController {
  ValueNotifier<AuthState> state = ValueNotifier(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      fetchUserDetails();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        state.value = AuthError('Email incorreto ou senha incorreta');
      } else {
        state.value = AuthError('Erro desconhecido: ${e.message}');
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    if (passwordConfirmed(
        password: password, confirmpasswordcontroller: password)) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        await _addUserDetails(firstName, lastName, email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          state.value = AuthError('A senha fornecida é muito fraca.');
        } else if (e.code == 'email-already-in-use') {
          state.value = AuthError('A conta já existe para esse e-mail.');
        } else {
          state.value = AuthError('Erro desconhecido: ${e.message}');
        }
      }
    }
  }

  Future<void> _addUserDetails(
    String firstName,
    String lastName,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection("users").add(
      {
        'firstname': firstName,
        'lastname': lastName,
        'email': email,
      },
    );
    fetchUserDetails();
  }

  bool passwordConfirmed(
      {required String password, required String confirmpasswordcontroller}) {
    return password.trim() == confirmpasswordcontroller.trim();
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      state.value = AuthInitial();
    } on FirebaseAuthException {
      state.value = AuthError('Erro ao fazer logout');
    }
  }

  Future<void> fetchUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email!)
          .get()
          .then(
        (QuerySnapshot doc) {
          final data = doc.docs.first.data() as Map<String, dynamic>;
          data['emailVerified'] = user.emailVerified;
          return data;
        },
      );
      state.value = AuthData(UserModel.fromFirestore(userSnapshot));
    }
  }
}
