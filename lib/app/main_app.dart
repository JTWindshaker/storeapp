import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';
import 'package:google_fonts/google_fonts.dart';

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
        GoRoute(
          path: "/home",
          name: "home",
          builder: (_, _) => const HomePage(),
        ),
      ],
    );

    return MaterialApp.router(
      theme: ThemeData(textTheme: GoogleFonts.patrickHandTextTheme()),
      routerConfig: router,
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
