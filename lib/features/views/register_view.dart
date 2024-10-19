import 'package:almora_pedidos/core/utils/utils.dart';
import 'package:almora_pedidos/features/views/views.dart';
import 'package:almora_pedidos/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  static const name = 'register_view';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _globalKey = GlobalKey<FormState>();

  bool _showPassword = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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

                    gapH(20),

                    const CustomLabel(
                      text: 'Crea una cuenta',
                      size: 34,
                      fontWeight: FontWeight.w600,
                    ),
                    const CustomLabel(
                      text: 'para empezar',
                      size: 24,
                    ),

                    gapH(32),

                    // Inputs de formularios

                    const CustomLabel(
                      text: 'Nombre',
                      size: 16,
                    ),
                    gapH(5),
                    CustomInput(
                      labelText: 'E.x. Juan Perez',
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Por favor ingresa un nombre';
                        }
                        return null;
                      },
                    ),

                    gapH(15),

                    const CustomLabel(
                      text: 'Email',
                      size: 16,
                    ),
                    gapH(5),
                    CustomInput(
                      labelText: 'E.x. Example@example.com',
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

                    gapH(15),

                    const CustomLabel(
                      text: 'Contraseña',
                      size: 16,
                    ),

                    gapH(5),

                    CustomInput(
                      keyboardType: TextInputType.visiblePassword,
                      labelText: '********',
                      showPassword: _showPassword ? false : true,
                      controller: _passwordController,
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
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa una contraseña';
                        }
                        return null;
                      },
                    ),

                    gapH(15),

                    const CustomLabel(
                      text: 'Confirmar contraseña',
                      size: 16,
                    ),

                    gapH(5),

                    CustomInput(
                      labelText: '********',
                      showPassword: _showPassword ? false : true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
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
                        text: 'Registrarse',
                        onTap: () {
                          context.pop();
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomLabel(
                          text: 'No tienes cuenta?',
                        ),
                        TextButton(
                          onPressed: () => context.go('/${LoginView.name}'),
                          child: const CustomLabel(text: 'Iniciar sesión'),
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
