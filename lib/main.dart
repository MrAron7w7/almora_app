import 'package:almora_pedidos/core/constants/app_route_view.dart';
import 'package:almora_pedidos/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      routerConfig: appRoute,
      theme: AppTheme.appTheme,
    );
  }
}
