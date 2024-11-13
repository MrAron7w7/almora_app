import 'package:almora_pedidos/features/models/product.dart';
import 'package:almora_pedidos/features/viewmodels/auth/auth_gate.dart';
import 'package:almora_pedidos/features/views/views.dart';
import 'package:go_router/go_router.dart';

final appRoute = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: AuthGate.name,
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/${LoginView.name}',
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
    GoRoute(
      path: '/${DetailView.name}',
      builder: (context, state) {
        // Obtén el objeto Product desde extra
        final product = state.extra as Product;
        return DetailView(product: product);
      },
    ),
    GoRoute(
      path: '/${FavoriteView.name}',
      builder: (context, state) => const FavoriteView(),
    ),
    GoRoute(
      path: '/${ShoppingCartView.name}',
      builder: (context, state) => const ShoppingCartView(),
    ),
    GoRoute(
      path: '/${PaymentConfirmationView.name}',
      builder: (context, state) => const PaymentConfirmationView(),
    ),
  ],
);
