import 'dart:developer';

import 'package:almora_pedidos/features/models/product.dart';
import 'package:almora_pedidos/features/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
  Servicio de base de datos - guardamos los datos
 */

class DatabaseService {
  // Tenemos la instancia
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /*
    Guardamos el usuario despeus de iniciar session
   */

  Future<void> saveUserInToFirebase({
    required String name,
    required String email,
  }) async {
    // Primero obtenemos el uid
    String uid = _auth.currentUser!.uid;

    // Creamos el usuario
    UserProfile user = UserProfile(
      uid: uid,
      email: email,
      name: name,
    );

    // Lo convertimos a un ( MAP ) para poder guardarlo en la base de datos
    final userMap = user.toMap();

    // Guardamos el usuario en la base de datos
    await _db.collection('Users').doc(uid).set(userMap);
  }

  /*
    Obtenemos el usuario actual
   */
  Future<UserProfile?> getUserFromFirebase({required String uid}) async {
    try {
      // Recibir el doc del user de firebase
      DocumentSnapshot userDoc = await _db.collection('Users').doc(uid).get();

      return UserProfile.fromDocument(userDoc);
    } catch (e) {
      log('Error al obtener el usuario: $e');
      return null;
    }
  }

  /*
    Agregamos los productos por usuario
   */
  Future<void> saveInToFirebase({
    required List<Product> boughtProducts,
  }) async {
    try {
      // Obtenemos el uid del usuario actual de la compra
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Obtenemos el usuario que va comprar actualmente
      final userName = await getUserFromFirebase(uid: uid);

      // Guardamos cada producto comprado a fibse
      for (var product in boughtProducts) {
        Product newProduct = Product(
          id: '',
          uid: uid,
          userName: userName!.name,
          name: product.name,
          description: product.description,
          price: product.price,
          category: product.category,
        );

        await FirebaseFirestore.instance
            .collection('products')
            .add(newProduct.toMap());
      }
    } catch (e) {
      log('Error al guardar los productos: $e');
    }
  }
}
