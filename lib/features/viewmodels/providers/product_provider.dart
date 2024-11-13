import 'package:almora_pedidos/features/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductFavorite extends _$ProductFavorite {
  @override
  List<Product> build() {
    return products; // Lista de producto inicial
  }

  void toggleFavorite(Product product) {
    state = [
      for (final p in state)
        if (p.name == product.name) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }

  void addToCart(Product product) {
    state = [
      for (final p in state)
        if (p.name == product.name)
          p.copyWith(
              isbought: true, quantity: p.quantity + 1) // Incrementa cantidad
        else
          p,
    ];
  }

  void incrementQuantity(Product product) {
    state = [
      for (final p in state)
        if (p.name == product.name) p.copyWith(quantity: p.quantity + 1) else p,
    ];
  }

  void decrementQuantity(Product product) {
    state = [
      for (final p in state)
        if (p.name == product.name && p.quantity > 1)
          p.copyWith(quantity: p.quantity - 1)
        else
          p,
    ];
  }

  void removeFromCart(Product product) {
    state = [
      for (final p in state)
        if (p.name == product.name)
          p.copyWith(isbought: false, quantity: 0)
        else
          p,
    ];
  }

  void resetFavorites() {
    state = [
      for (final p in products)
        p.copyWith(isFavorite: false, isbought: false, quantity: 0)
    ];
  }
}

@Riverpod(keepAlive: true)
class CounterQuantity extends _$CounterQuantity {
  @override
  int build() {
    return 1;
  }

  void incrementQuantity() {
    if (state < 10) {
      state++;
    }
  }

  void decrementQuantity() {
    if (state > 1) {
      state--;
    }
  }

  void resetCounter() => state = 1;
}

// Provider para filtrar solo los productos favoritos
@riverpod
List<Product> favoriteProducts(FavoriteProductsRef ref) {
  final products = ref.watch(productFavoriteProvider);
  return products.where((product) => product.isFavorite).toList();
}

// Provider para filtrar los que ya son añadidos al carrito
@riverpod
List<Product> boughtProducts(FavoriteProductsRef ref) {
  final products = ref.watch(productFavoriteProvider);
  return products.where((product) => product.isbought).toList();
}

// Provider de contar la cantidad de items para el carrito
@riverpod
int CounterQuantityItem(CounterQuantityItemRef ref) {
  final products = ref.watch(productFavoriteProvider);
  return products.where((product) => product.isbought).length;
}
