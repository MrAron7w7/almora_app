// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteProductsHash() => r'30b38419ec095e6ae3919a7fb0cf0b66a9188dd8';

/// See also [favoriteProducts].
@ProviderFor(favoriteProducts)
final favoriteProductsProvider = AutoDisposeProvider<List<Product>>.internal(
  favoriteProducts,
  name: r'favoriteProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteProductsRef = AutoDisposeProviderRef<List<Product>>;
String _$boughtProductsHash() => r'0d5d2a35a7f563f61f53b51ff3fc7239d603ca4f';

/// See also [boughtProducts].
@ProviderFor(boughtProducts)
final boughtProductsProvider = AutoDisposeProvider<List<Product>>.internal(
  boughtProducts,
  name: r'boughtProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$boughtProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef BoughtProductsRef = AutoDisposeProviderRef<List<Product>>;
String _$counterQuantityItemHash() =>
    r'b4452eca64905cb446103e8c97e6c84771343a8a';

/// See also [CounterQuantityItem].
@ProviderFor(CounterQuantityItem)
final counterQuantityItemProvider = AutoDisposeProvider<int>.internal(
  CounterQuantityItem,
  name: r'counterQuantityItemProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$counterQuantityItemHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CounterQuantityItemRef = AutoDisposeProviderRef<int>;
String _$productFavoriteHash() => r'cd791cd83acd7d81465197713697f1120225def7';

/// See also [ProductFavorite].
@ProviderFor(ProductFavorite)
final productFavoriteProvider =
    NotifierProvider<ProductFavorite, List<Product>>.internal(
  ProductFavorite.new,
  name: r'productFavoriteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productFavoriteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductFavorite = Notifier<List<Product>>;
String _$counterQuantityHash() => r'93e085e8fa8573374775ca004e600ecfb6f7233c';

/// See also [CounterQuantity].
@ProviderFor(CounterQuantity)
final counterQuantityProvider = NotifierProvider<CounterQuantity, int>.internal(
  CounterQuantity.new,
  name: r'counterQuantityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$counterQuantityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CounterQuantity = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
