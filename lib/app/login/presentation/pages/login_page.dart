import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap:
              () =>
                  FocusScope.of(
                    context,
                  ).unfocus(), // Ocultar teclado al tocar fuera
          child: Stack(
            children: [
              // Fondo con degradado
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFF28B82), Color(0xFFAEC6CF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom +
                        32, // Ajuste automático
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HeaderLoginWidget(),
                          const SizedBox(height: 16.0),
                          BodyLoginWidget(),
                          const SizedBox(height: 32.0),
                          FooterLoginWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/logo.png", height: 120.0, fit: BoxFit.cover),
        const SizedBox(height: 20.0),
        const Text(
          "Store App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFEF1D26), // Color principal
          ),
        ),
      ],
    );
  }
}

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> {
  bool showPassword = false;

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });

    if (showPassword) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            showPassword = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          style: TextStyle(fontSize: 14),
          decoration: const InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(Icons.email, color: Color(0xFF6F6758)),
            labelStyle: TextStyle(color: Color(0xFF6F6758)),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF6F6758)),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16.0),
        TextField(
          obscureText: !showPassword,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: const Icon(Icons.lock, color: Color(0xFF6F6758)),
            labelStyle: const TextStyle(color: Color(0xFF6F6758)),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF6F6758)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                showPassword ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF6F6758),
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
        ),
        const SizedBox(height: 48.0),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF1D26), // Color principal
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text(
            "Iniciar Sesión",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "¿No tienes cuenta?",
          style: TextStyle(color: Color(0xFF6F6758), fontSize: 12),
        ),
        TextButton(
          onPressed: () => GoRouter.of(context).pushNamed("sign-up"),
          child: const Text(
            "Regístrate aquí",
            style: TextStyle(fontSize: 14.0, color: Color(0xFFEF1D26)),
          ),
        ),
      ],
    );
  }
}
