import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/viewmodels/providers/product_provider.dart';
import 'package:almora_pedidos/features/views/views.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PaymentConfirmationView extends ConsumerStatefulWidget {
  const PaymentConfirmationView({super.key});

  static const name = 'payment_confirmation_view';

  @override
  ConsumerState<PaymentConfirmationView> createState() =>
      _PaymentConfirmationViewState();
}

class _PaymentConfirmationViewState
    extends ConsumerState<PaymentConfirmationView> {
  bool _isProcessing = true;
  bool _isPaymentSuccessful = false;

  @override
  void initState() {
    super.initState();
    _simulatePaymentProcess();
  }

  // Simula el proceso de pago con un Future.delayed -> Retener por 2s
  void _simulatePaymentProcess() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isProcessing = false;
        _isPaymentSuccessful = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Reseteamos los valores de los providers.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade200,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const CustomLabel(
          text: 'Confirmación de Pago',
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Center(
        child: _isProcessing
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  gapH(20),
                  const CustomLabel(
                    text: 'Procesando el pago...',
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )
            : _isPaymentSuccessful
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100,
                      ),
                      const SizedBox(height: 20),
                      const CustomLabel(
                        text: 'Pago exitoso',
                        fontWeight: FontWeight.w600,
                        size: 24,
                      ),
                      gapH(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                            text: 'Volver al inicio',
                            onTap: () {
                              ref
                                  .read(productFavoriteProvider.notifier)
                                  .resetFavorites();
                              ref
                                  .read(counterQuantityProvider.notifier)
                                  .resetCounter();
                              context.go('/${HomeView.name}');
                            }),
                      ),
                    ],
                  )
                : const CustomLabel(
                    text: 'Ha ocurrido un error en el pago',
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
      ),
    );
  }
}
