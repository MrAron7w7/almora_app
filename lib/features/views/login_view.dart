import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/views/views.dart';
import 'package:almora_pedidos/shared/components/custom_button.dart';
import 'package:almora_pedidos/shared/components/custom_input.dart';
import 'package:almora_pedidos/shared/components/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  static const name = '/';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _globalKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _showPassword = false;

  @override
  void initState() {
    _emailController.text = 'test@gmail.com';
    _passwordController.text = '123456';
    super.initState();
  }

  void validateData() {
    showCircularLoading(context);
    if (_globalKey.currentState!.validate()) {
      context.go('/${HomeView.name}');
      if (mounted) closeCircularLoading(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          width: size.width,
          height: size.height,
          child: SafeArea(
            child: Form(
              key: _globalKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.store,
                          size: 36,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        gapW(10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabel(
                              text: 'Almorat',
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            CustomLabel(
                              text: 'Pedidos',
                              size: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ],
                    ),

                    gapH(32),

                    const CustomLabel(
                      text: 'Bienvenido',
                      size: 34,
                      fontWeight: FontWeight.w600,
                    ),
                    const CustomLabel(
                      text: 'Ingresa tus credenciales',
                      size: 24,
                    ),

                    gapH(32),

                    // Inputs de formularios
                    const CustomLabel(
                      text: 'Email',
                      size: 16,
                    ),
                    gapH(8),
                    CustomInput(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Por favor ingresa un email';
                        }
                        return null;
                      },
                    ),

                    gapH(20),

                    const CustomLabel(
                      text: 'Contraseña',
                      size: 16,
                    ),

                    gapH(8),

                    CustomInput(
                      labelText: 'Contraseña',
                      keyboardType: TextInputType.visiblePassword,
                      showPassword: _showPassword ? false : true,
                      icon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      controller: _passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        return null;
                      },
                    ),

                    gapH(32),

                    Align(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: 'Ingresar',
                        onTap: validateData,
                      ),
                    ),

                    gapH(32),

                    // Si no tiene cuenta
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomLabel(
                          text: 'No tienes cuenta?',
                        ),
                        TextButton(
                          onPressed: () =>
                              context.push('/${RegisterView.name}'),
                          child: const CustomLabel(text: 'Registrate'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
