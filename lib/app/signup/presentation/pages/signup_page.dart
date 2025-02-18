import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Página de registro", style: TextStyle(fontSize: 48.0)),
            OutlinedButton(
              onPressed: () => GoRouter.of(context).pop(), // Se usa pop para regresar atrás
              // onPressed: () => GoRouter.of(context).pushNamed("login"), //Empieza a sobreponer ventanas sobre ventana. Mala practica. Esto se usa para ir de pantalla en pantalla.
              child: Text("Ir a Login"),
            ),
          ],
        ),
      ),
    );
  }
}
