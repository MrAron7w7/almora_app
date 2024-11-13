import 'package:almora_pedidos/features/views/views.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/*
   AUTH GATE

   Chekea si el usuario ya ha iniciado session o no

   y si ha iniciado se dirige a la pantalla principal

   y si no al login
 */

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  static const name = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Si el usuario esta logeado
          if (snapshot.hasData) {
            return const HomeView();

            // y si no
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}
