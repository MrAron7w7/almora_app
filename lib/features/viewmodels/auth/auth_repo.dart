import 'package:almora_pedidos/features/models/user.dart';

/*
  Se creara una clase AuthRepo con los metodos 
  - loginWithEmailPassword  
  - registerWithEmailPassword 
  - logout
  - getCurrentUser
*/

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(
      {required String email, required String password});

  Future<AppUser?> registerWithEmailPassword(
      {required String email, required String password, required String name});

  Future<void> logout();
  Future<AppUser?> getCurrentUser();
}
