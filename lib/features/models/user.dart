/*
  Se creara la clase User con los atributos uid, email y name
  para almacenar los datos en Firebase

*/

class AppUser {
  final String uid;
  final String email;
  final String name;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
  });

  // firebase -> app
  // Convierte la instancia de AppUser en un Map<String, dynamic> para almacenar en Firestore.

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }

  // app -> firebase
  // Crea una instancia de AppUser a partir de un Map<String, dynamic> obtenido de Firestore.
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }
}
