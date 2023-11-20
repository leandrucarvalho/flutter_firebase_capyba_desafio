
import 'package:flutter_firebase_capyba_desafio/models/user_model.dart';

sealed class AuthState {}

class AuthInitial implements AuthState {}

class AuthData implements AuthState {
  final UserModel user;

  AuthData(this.user);
}

class AuthError implements AuthState {
  final String error;
  AuthError(this.error);
}

class AuthLoading implements AuthState {}
