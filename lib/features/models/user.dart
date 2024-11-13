import 'package:cloud_firestore/cloud_firestore.dart';
/*
  Se creara la clase User con los atributos uid, email y name
  para almacenar los datos en Firebase

*/

class UserProfile {
  final String uid;
  final String email;
  final String name;

  UserProfile({
    required this.uid,
    required this.email,
    required this.name,
  });

  // App -> Firebase
  // Convierte la instancia de UserProfile en un Map<String, dynamic> para almacenar en Firestore.

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  // Fireabse -> APP
  // Crea una instancia de UserProfile a partir de un DocumentSnapshot obtenido de Firestore.
  factory UserProfile.fromDocument(DocumentSnapshot doc) {
    return UserProfile(
      uid: doc['uid'],
      email: doc['email'],
      name: doc['name'],
    );
  }
}
