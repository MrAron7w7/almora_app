import 'package:firebase_auth/firebase_auth.dart';

/* 

  Se creara una clase FirebaseAuthRepo con los metodos 
  - loginWithEmailPassword  
  - registerWithEmailPassword 
  - logout
  - getCurrentUser

  en la cual hara la logica de la autenticacion
*/

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Obtener el usuario y su uid
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUid() => _auth.currentUser!.uid;

  // Logearse con email y password
  Future<UserCredential> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception('Error al iniciar sesión: ${e.code}');
    }
  }

  // Registrarse con email y password
  Future<UserCredential> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("Error al registrarse: ${e.code}");
    }
  }

  // Salir session
  Future<void> logOut() async {
    await _auth.signOut();
  }
}
