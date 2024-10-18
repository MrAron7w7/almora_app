import 'package:almora_pedidos/features/views/home_view.dart';
import 'package:go_router/go_router.dart';

final appRoute = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeView(),
    ),
  ],
);
