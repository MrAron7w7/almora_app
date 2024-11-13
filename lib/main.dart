import 'package:almora_pedidos/core/constants/app_route_view.dart';
import 'package:almora_pedidos/firebase_options.dart';
import 'package:almora_pedidos/shared/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Almora Pedidos',
      debugShowCheckedModeBanner: false,
      routerConfig: appRoute,
      theme: AppTheme.appTheme,
    );
  }
}
