import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/models/product.dart';
import 'package:almora_pedidos/features/viewmodels/providers/product_provider.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailView extends ConsumerWidget {
  final Product product;
  const DetailView({super.key, required this.product});

  static const name = 'detail_view';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    final products = ref.watch(productFavoriteProvider);

    final currentProduct = products.firstWhere((p) => p.name == product.name);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            // Imagen de fondo que ocupa el 100% del ancho
            SizedBox(
              width: size.width,
              height: size.height * 0.5,
              child: Hero(
                tag: product.description,
                child: Image.network(
                  product.image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //Descripcion del contenido
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.45,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabel(
                                  text: product.name,
                                  size: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                // Calificación
                                const SizedBox(height: 8),
                                const Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber),
                                    Icon(Icons.star, color: Colors.amber),
                                    Icon(Icons.star, color: Colors.amber),
                                    Icon(Icons.star, color: Colors.amber),
                                    Icon(Icons.star, color: Colors.grey),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              ref
                                  .read(productFavoriteProvider.notifier)
                                  .toggleFavorite(product);
                            },
                            icon: Icon(
                              currentProduct.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              size: 28,
                              color: currentProduct.isFavorite
                                  ? const Color(0xff79111C)
                                  : null,
                            ),
                          ),
                        ],
                      ),

                      gapH(20),

                      // Descripción
                      CustomLabel(
                        text: product.description,
                      ),

                      gapH(20),

                      // Botón de comprar
                      Row(
                        children: [
                          Expanded(
                            child: CustomLabel(
                              text: 'S/${product.price}0',
                              size: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                padding: const EdgeInsets.all(0),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                textStyle: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                ref
                                    .watch(productFavoriteProvider.notifier)
                                    .addToCart(product);
                              },
                              child: CustomLabel(
                                text: currentProduct.isbought
                                    ? 'Añadido'
                                    : 'Añadir al carrito',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
