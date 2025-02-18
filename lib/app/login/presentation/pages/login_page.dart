import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // child: Text('Hola desde Login VSCode'),
      // Container admite estilos
      // SizedBox es para controlar alturas y anchos
      Column(
        children: [HeaderLoginWidget(), BodyLoginWidget(), FooterLoginWidget()],
      ),
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: Column(
        children: [
          Divider(height: 50.0, thickness: 2.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, //Justify Content
            children: [
              Text("Aún no tiene cuenta?"),
              SizedBox(width: 24.0),
              GestureDetector(
                onTap: () => GoRouter.of(context).pushNamed("sign-up"),
                child: Text(
                  "Registrate acá",
                  style: TextStyle(
                    color: Colors.purple,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.purple,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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

  @override
  Widget build(BuildContext context) {
    // El Expanded, hace que ocupe todo le tamaño disponible entre widget en la pantalla.
    return Expanded(
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 24.0),
        margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 80.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                icon: Icon(Icons.person),
                hintText: "Escriba su email",
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            // Forma 1 de hacer espacios
            SizedBox(height: 16.0),
            TextField(
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: "Password",
                icon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap:
                      () => setState(() {
                        showPassword = !showPassword;
                      }),
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                hintText: "Escriba su password",
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
            // Forma 1 de hacer espacios
            SizedBox(height: 16.0),
            //Si es función de flecha, es una sola línea
            FilledButton(
              onPressed: () => {},
              child: SizedBox(
                width: double.infinity,
                child: Text("Iniciar Sesión", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blue,
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            width: double.infinity,
            height: 100.0,
            // fit: BoxFit.fitWidth, //Igual de Cover
            // fit: BoxFit.cover,
            fit: BoxFit.fitHeight,
            "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Thresh_6.jpg",
          ),
          SizedBox(
            width: double.infinity,
            // Todo se puede volver clickeable. Toca abrazarlo en un Gesture Detector
            child: Text(
              "Iniciar Sesión",
              style: TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
