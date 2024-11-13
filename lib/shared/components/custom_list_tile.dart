import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  final String counter;
  final double price;
  final String image;
  final void Function()? onTap;
  final void Function()? removeProduct;
  final void Function()? addProduct;

  const CustomListTile({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    this.onTap,
    this.removeProduct,
    this.addProduct,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Row(
          children: [
            // Imagen
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),

            gapW(10),

            // Nombre y precio -> Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLabel(
                    text: name,
                    fontWeight: FontWeight.w700,
                    size: 14,
                  ),
                  CustomLabel(
                    text: 'S/$price',
                    fontWeight: FontWeight.w500,
                    size: 16,
                  ),
                ],
              ),
            ),

            const Spacer(),

            // Botones de acciones
            Row(
              children: [
                // Boton de menos
                InkWell(
                  onTap: removeProduct,
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const CustomLabel(text: '-'),
                  ),
                ),

                gapW(5),

                // contador
                Container(
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xffEDEDED),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CustomLabel(text: counter),
                ),

                gapW(5),

                // Boton de mas
                InkWell(
                  onTap: addProduct,
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xffEDEDED),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const CustomLabel(text: '+'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
