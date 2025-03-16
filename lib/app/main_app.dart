import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/form_product/presentation/pages/form_product_page.dart';
import 'package:storeapp/app/home/presentation/pages/home_page.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';
import 'package:storeapp/app/users/presentation/pages/users_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: "/",
          name: "login",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;

            if (authenticated) {
              return "/home";
            }

            return null;
          },
          builder: (_, _) => LoginPage(),
        ),
        GoRoute(
          path: "/sign-up",
          name: "sign-up",
          builder: (_, _) => SignupPage(),
        ),
        GoRoute(
          path: "/home",
          name: "home",
          redirect: (context, state) async {
            final prefs = await SharedPreferences.getInstance();
            final bool authenticated = prefs.getBool("login") ?? false;

            if (!authenticated) {
              return "/";
            }

            return null;
          },
          builder: (_, _) => HomePage(),
        ),
        GoRoute(
          path: "/form-product",
          name: "form-product",
          builder: (_, _) => FormProductPage(),
        ),
        GoRoute(
          path: "/form-product/:id",
          name: "form-product-u",
          builder:
              (_, state) => FormProductPage(id: state.pathParameters["id"]),
        ),
        GoRoute(
          path: "/users",
          name: "users",
          builder: (_, _) => UsersPage(),
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
