import 'package:almora_pedidos/shared/components/components.dart';
import 'package:flutter/material.dart';

// Espaciado personalizado para el ancho
SizedBox gapW(double w) {
  return SizedBox(width: w);
}

// Espaciado personalizado para el alto
SizedBox gapH(double h) {
  return SizedBox(height: h);
}

// Mostrar un dialogo de cargando
void showCircularLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      backgroundColor: Colors.transparent,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}

// Cerrar el dialogo de cargando
void closeCircularLoading(BuildContext context) {
  Navigator.of(context).pop();
}

// Mostrar dialogo para confirmar si queremos o no eliminar algo

void showDialogDelete(
  BuildContext context, {
  required String title,
  required String content,
  required void Function()? actionAcept,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: CustomLabel(text: title),
      content: CustomLabel(text: content),
      actions: [
        TextButton(
          child: const CustomLabel(
            text: 'Cancelar',
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          onPressed: actionAcept,
          child: const CustomLabel(
            text: 'Aceptar',
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
