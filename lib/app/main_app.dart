import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: "/", name: "login", builder: (_, _) => const LoginPage()),
        GoRoute(
          path: "/sign-up",
          name: "sign-up",
          builder: (_, _) => const SignUpPage(),
        ),
      ],
    );

    return SafeArea(
      bottom: false,
      child: MaterialApp.router(routerConfig: router),
    );
  }
}

class TestStatefull extends StatefulWidget {
  const TestStatefull({super.key});

  @override
  State<TestStatefull> createState() => TestStatefullState();
}

class TestStatefullState extends State<TestStatefull> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
