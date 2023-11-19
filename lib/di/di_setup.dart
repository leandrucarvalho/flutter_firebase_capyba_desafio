import 'package:flutter_firebase_capyba_desafio/controller/home_controller.dart';
import 'package:flutter_firebase_capyba_desafio/controller/restricted_controller.dart';
import 'package:flutter_firebase_capyba_desafio/controller/user_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<UserController>(UserController());
  getIt.registerSingleton<HomeController>(HomeController());
  getIt.registerSingleton<RestrictedController>(RestrictedController());
}
