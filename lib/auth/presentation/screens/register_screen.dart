import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/widgets/widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: scaffoldBackgroundColor,
        body: AnimatedBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (!context.canPop()) return;
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      'Crear cuenta',
                      style: textStyles.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),

                const SizedBox(height: 50),

                Container(
                  height: size.height - 260,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: _RegisterForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const Spacer(flex: 2),
          Text('Nueva cuenta', style: textStyle.titleMedium),
          const Spacer(),

          const CustomInput(label: 'Nombre completo'),

          const SizedBox(height: 30),
          CustomInput(
            label: 'Número de documento',
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 30),
          CustomInput(
            label: 'Correo electrónico',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 30),
          CustomInput(label: 'Telefono', keyboardType: TextInputType.phone),
          const SizedBox(height: 30),
          CustomInput(
            label: 'Fecha de nacimiento',
            keyboardType: TextInputType.datetime,
          ),

          const SizedBox(height: 30),
          CustomInput(
            label: 'Contraseña',
            keyboardType: TextInputType.visiblePassword,
          ),

          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomButton(
              label: 'Crear',
              buttonColor: Colors.black,
              onPressed: () {},
            ),
          ),

          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    return context.pop();
                  }

                  context.go('/login');
                },
                child: const Text('Ingresa aquí'),
              ),
            ],
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
