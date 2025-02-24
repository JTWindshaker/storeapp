import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Inicio!!!"),
            FilledButton(
              onPressed: () {
                GoRouter.of(context).pushReplacementNamed("login");
              },
              child: Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
