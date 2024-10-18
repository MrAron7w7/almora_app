import 'package:almora_pedidos/features/models/user.dart';
import 'package:almora_pedidos/features/viewmodels/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* 

  Se creara una clase FirebaseAuthRepo con los metodos 
  - loginWithEmailPassword  
  - registerWithEmailPassword 
  - logout
  - getCurrentUser

  en la cual hara la logica de la autenticacion
*/

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      // Retorno el user
      return user;
    } catch (e) {
      throw Exception('Logeo fallido: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // Retorno el user
      return user;
    } catch (e) {
      throw Exception('Registro fallido: $e');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // Obtener si el usuario esta logeado de firebae
    final firebaseUser = _firebaseAuth.currentUser;

    // Si usuario no esta logeado
    if (firebaseUser == null) {
      return null;
    }

    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: '',
    );
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
