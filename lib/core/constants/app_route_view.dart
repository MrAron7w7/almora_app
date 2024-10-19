import 'package:almora_pedidos/features/views/views.dart';
import 'package:go_router/go_router.dart';

final appRoute = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: LoginView.name,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/${RegisterView.name}',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/${HomeView.name}',
      builder: (context, state) => const HomeView(),
    ),
  ],
);
