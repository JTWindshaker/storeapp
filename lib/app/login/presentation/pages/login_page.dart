import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/login/presentation/bloc/login_event.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/pages/login_mixin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<LoginBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: GestureDetector(
            // onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
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
        // body: SafeArea(
        //   child: GestureDetector(
        //     // Ocultar teclado al tocar fuera
        //     onTap: () => FocusScope.of(context).unfocus(),
        //     child: Stack(
        //       children: [
        //         // Fondo con degradado
        //         Positioned.fill(
        //           child: Container(
        //             decoration: const BoxDecoration(
        //               gradient: LinearGradient(
        //                 colors: [Color(0xFFF28B82), Color(0xFFAEC6CF)],
        //                 begin: Alignment.topLeft,
        //                 end: Alignment.bottomRight,
        //               ),
        //             ),
        //           ),
        //         ),
        //         Center(
        //           child: SingleChildScrollView(
        //             keyboardDismissBehavior:
        //                 ScrollViewKeyboardDismissBehavior.onDrag,
        //             padding: EdgeInsets.only(
        //               left: 32,
        //               right: 32,
        //               bottom:
        //                   MediaQuery.of(context).viewInsets.bottom +
        //                   32, // Ajuste automático
        //             ),
        //             child: Card(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(16.0),
        //               ),
        //               elevation: 8.0,
        //               child: Padding(
        //                 padding: const EdgeInsets.all(32.0),
        //                 child: Column(
        //                   mainAxisSize: MainAxisSize.min,
        //                   children: [
        //                     HeaderLoginWidget(),
        //                     const SizedBox(height: 16.0),
        //                     BodyLoginWidget(),
        //                     const SizedBox(height: 32.0),
        //                     FooterLoginWidget(),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
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

class _BodyLoginWidgetState extends State<BodyLoginWidget> with LoginMixin {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final keyForm = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    _autoShowTimer?.cancel();

    if (!_showPassword) {
      _autoShowTimer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showPassword = false;
          });
        }
      });
    }

    setState(() {
      _showPassword = !_showPassword;
    });

    // if (_showPassword) {
    //   Future.delayed(const Duration(seconds: 5), () {
    //     if (mounted) {
    //       setState(() {
    //         _showPassword = false;
    //       });
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case LoginSuccessState():
            GoRouter.of(context).pushReplacementNamed("home");
            break;
          case LoginErrorState():
            _showMyDialog(state.message);
            break;
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final bool isValidForm =
              validateEmail(state.model.email) == null &&
              validatePassword(state.model.password) == null;

          emailController.text = state.model.email;
          passwordController.text = state.model.password;

          // if (state is LoginSuccessState) {
          //   WidgetsBinding.instance.addPostFrameCallback((_) {
          //     GoRouter.of(context).pushReplacementNamed("home");
          //   });
          // }

          // switch (state) {
          //   case DataUpdateState():
          //     print(state.model.email);
          //     break;
          //   default:
          // }

          // return Container(
          //   color: Colors.amber,
          //   child: InkWell(
          //     onTap: () {
          //       bloc.add(EmailChangedEvent(email: "Cambio Email"));
          //     },
          //     child: Text("data"),
          //   ),
          // );
          return Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  onChanged:
                      (value) => bloc.add(EmailChangedEvent(email: value)),
                  validator: validateEmail,
                  style: TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email, color: Color(0xFF6F6758)),
                    hintText: "Email",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: passwordController,
                  onChanged:
                      (value) =>
                          bloc.add(PasswordChangedEvent(password: value)),
                  validator: validatePassword,
                  obscureText: !_showPassword,
                  style: TextStyle(fontSize: 14),

                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Color(0xFF6F6758),
                    ),
                    // labelStyle: const TextStyle(color: Color(0xFF6F6758)),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: togglePasswordVisibility,
                    ),
                    hintText: "Password",
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 48.0),
                ElevatedButton(
                  // onPressed: () => keyForm.currentState?.validate(),
                  // onPressed:
                  //     isValidForm
                  //         ? () {
                  //           setState(() {
                  //             bloc.add(SubmitEvent());
                  //           });
                  //         }
                  //         : null,
                  onPressed: isValidForm ? () => bloc.add(SubmitEvent()) : null,
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
            ),
          );
        },
      ),
    );
  }

  Future<void> _showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                // Text('Otro Texto'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
