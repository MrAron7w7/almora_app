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
