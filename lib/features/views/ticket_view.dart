import 'dart:developer';
import 'dart:io';

import 'package:almora_pedidos/features/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart' as path;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class TicketView extends StatefulWidget {
  final String userName;
  final List<Product> products;

  const TicketView({
    super.key,
    required this.userName,
    required this.products,
  });

  @override
  State<TicketView> createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  double get _total {
    // Total de la suma de los productos price * quantity
    return widget.products.fold(
      0.0,
      (total, product) => total + (product.price * product.quantity),
    );
  }

  // Inicializamos los permisos funcionales de version androd 10 pa bajo
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    PermissionStatus status = await Permission.storage.request();
    if (!status.isGranted) {
      log('No se concedió el permiso de almacenamiento');
    }
  }

  // Metodo generar pdf 8 b
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    final font =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(height: 20),
              pw.Center(
                child: pw.Text(
                  'ALMORA - BOLETA DE PEDIDO',
                  style: pw.TextStyle(
                    font: font,
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Nombre del Usuario: ${widget.userName}',
                    style: pw.TextStyle(font: font, fontSize: 14),
                  ),
                  pw.Text(
                    'Fecha: ${DateTime.now().toString().substring(0, 10)}',
                    style: pw.TextStyle(font: font, fontSize: 14),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Productos:',
                style: pw.TextStyle(font: font, fontSize: 16),
              ),
              pw.SizedBox(height: 10),
              ...widget.products.map((product) {
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      product.name,
                      style: pw.TextStyle(font: font, fontSize: 14),
                    ),
                    pw.Text(
                      'Cantidad: ${product.quantity}',
                      style: pw.TextStyle(font: font, fontSize: 14),
                    ),
                    pw.Text(
                      'Precio: S/${product.price}',
                      style: pw.TextStyle(font: font, fontSize: 14),
                    ),
                  ],
                );
              }),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'S/${_total.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      font: font,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }

  // Directorio de donde se va guadar
  Future<String> _getFilePath() async {
    const directory = '/storage/emulated/0/Download';
    final fileName =
        'generated_ticket_${DateTime.now().toString().substring(0, 10)}.pdf';
    final filePath = path.join(directory, fileName);
    return filePath;
  }

  // Metodo para descargar la musica
  Future<void> downloadPdf(Uint8List pdfData) async {
    final filePath = await _getFilePath();
    final file = File(filePath);
    await file.writeAsBytes(pdfData);
    log('Boleta guardada en: $filePath');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Boleta guardada en Descargas'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("BOLETA DE COMPRA"),
      ),
      body: FutureBuilder<Uint8List>(
        future: generatePdf(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final pdfData = snapshot.data!;
            return FutureBuilder<String>(
              future: _getFilePath(),
              builder: (context, pathSnapshot) {
                if (pathSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (pathSnapshot.hasError) {
                  return Center(child: Text('Error: ${pathSnapshot.error}'));
                } else if (pathSnapshot.hasData) {
                  final filePath = pathSnapshot.data!;
                  File(filePath).writeAsBytesSync(pdfData);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 600,
                            child: PDFView(
                              filePath: filePath,
                              enableSwipe: true,
                              swipeHorizontal: false,
                              autoSpacing: true,
                              pageFling: true,
                              // onPageChanged: (int? current, int? total) {
                              //   log('Página actual: $current de $total');
                              // },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.amber.shade300,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                downloadPdf(pdfData);
                              },
                              child: const Text('Descargar Boleta'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text('No se pudo generar el PDF'));
                }
              },
            );
          } else {
            return const Center(child: Text('No se pudo generar el PDF'));
          }
        },
      ),
    );
  }
}
