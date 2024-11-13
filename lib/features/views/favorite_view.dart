import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/viewmodels/providers/product_provider.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteView extends ConsumerWidget {
  const FavoriteView({super.key});
  static const name = 'favorite_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoriteProductsProvider);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
        centerTitle: true,
        title: const CustomLabel(
          text: 'Favoritos',
          fontWeight: FontWeight.w600,
        ),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: CustomLabel(text: 'No hay productos favoritos'),
            )
          : SizedBox(
              width: size.width,
              height: size.height,
              child: ListView.separated(
                separatorBuilder: (context, index) => gapH(10),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];

                  return ListTile(
                    onTap: () {},
                    leading: Image.network(
                      product.image.toString(),
                      fit: BoxFit.cover,
                    ),
                    title: CustomLabel(text: product.name),
                    subtitle: CustomLabel(text: '${product.price} \$'),
                    trailing: IconButton(
                      onPressed: () {
                        showDialogDelete(
                          context,
                          title: 'Eliminar de favoritos',
                          content: '¿Quieres quitarlo de favoritos?',
                          actionAcept: () {
                            ref
                                .read(productFavoriteProvider.notifier)
                                .toggleFavorite(product);
                            Navigator.pop(context);
                          },
                        );
                      },
                      icon: Icon(
                        favoriteProducts[index].isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favoriteProducts[index].isFavorite
                            ? const Color(0xff79111C)
                            : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
