import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/models/product.dart';
import 'package:almora_pedidos/features/viewmodels/database/database_service.dart';
import 'package:almora_pedidos/features/viewmodels/providers/product_provider.dart';
import 'package:almora_pedidos/features/views/ticket_view.dart';
import 'package:almora_pedidos/features/views/views.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShoppingCartView extends ConsumerStatefulWidget {
  const ShoppingCartView({super.key});
  static const name = 'shopping_cart_view';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShoppingCartViewState();
}

class _ShoppingCartViewState extends ConsumerState<ShoppingCartView> {
  final _databaseService = DatabaseService();

  Future<void> _generateTicket({required List<Product> boughtProducts}) async {
    /*
      Descomentar cuando ya este terminado el software
     */
    // _databaseService.saveInToFirebase(boughtProducts: boughtProducts);

    // Obtenemos el nombre del usuario
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userName = await _databaseService.getUserFromFirebase(uid: uid);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return TicketView(
          userName: userName!.name,
          products: boughtProducts,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final boughtProducts = ref.watch(boughtProductsProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber.shade200,
        title: const CustomLabel(
          text: 'Carrito de compras',
          fontWeight: FontWeight.w600,
        ),
      ),
      body: boughtProducts.isEmpty
          ? const Center(
              child: CustomLabel(text: 'No hay productos en el carrito'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: boughtProducts.length,
                    separatorBuilder: (context, index) => gapH(10),
                    itemBuilder: (context, index) {
                      final product = boughtProducts[index];

                      return _buildShoppingCart(context, ref, product);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    text: 'Generar boleta',
                    onTap: () =>
                        _generateTicket(boughtProducts: boughtProducts),
                  ),
                ),
              ],
            ),
    );
  }

  // Item de cada carte que hemos decidico comprar en la cual
  // al hacer slide se pueda eliminar con confirmacion
  Dismissible _buildShoppingCart(
    BuildContext context,
    WidgetRef ref,
    Product product,
  ) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _showDeleteConfirmationDialog(context, product),
      onDismissed: (direction) {
        ref.read(productFavoriteProvider.notifier).removeFromCart(product);
      },
      child: ListTile(
        onTap: () {
          context.push('/${DetailView.name}', extra: product);
        },
        leading: Image.network(
          product.image.toString(),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        subtitle: Text('S/${product.price}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                ref
                    .read(productFavoriteProvider.notifier)
                    .decrementQuantity(product);
              },
            ),
            CircleAvatar(
              radius: 12,
              child: CustomLabel(
                text: '${product.quantity}', // Mostrar la cantidad específica
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                ref
                    .read(productFavoriteProvider.notifier)
                    .incrementQuantity(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog(
      BuildContext context, Product product) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.delete, color: Colors.red.shade400),
            const SizedBox(width: 8),
            const CustomLabel(
              text: 'Eliminar producto',
              color: Colors.red,
              fontWeight: FontWeight.w600,
              size: 20,
            ),
          ],
        ),
        content: const CustomLabel(
          text: '¿Desea eliminar el producto del carrito?',
          color: Colors.grey,
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.amber.shade300,
            ),
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red.shade400,
            ),
            child: const Text('Eliminar'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }
}
