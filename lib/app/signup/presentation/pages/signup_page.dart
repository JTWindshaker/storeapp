import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/di/dependency_injection.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_bloc.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_event.dart';
import 'package:storeapp/app/signup/presentation/bloc/signup_state.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_mixin.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: DependencyInjection.serviceLocator.get<SignupBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: GestureDetector(
            // onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: BodySignupWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BodySignupWidget extends StatefulWidget {
  const BodySignupWidget({super.key});

  @override
  State<BodySignupWidget> createState() => BodySignupWidgetState();
}

class BodySignupWidgetState extends State<BodySignupWidget> with SignupMixin {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  Timer? _autoShowTimer;
  Timer? _autoShowTimerConfirm;
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
  }

  void togglePasswordVisibilityConfirm() {
    _autoShowTimerConfirm?.cancel();

    if (!_showConfirmPassword) {
      _autoShowTimerConfirm = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            _showConfirmPassword = false;
          });
        }
      });
    }

    setState(() {
      _showConfirmPassword = !_showConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupBloc>();

    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController imageController = TextEditingController();

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        switch (state) {
          case InitialState() || DataUpdateState():
            break;
          case SubmitSuccessState():
            GoRouter.of(context).pushReplacementNamed("login");
            break;
          case SubmitErrorState():
            _showMyDialog(state.message);
            break;
        }
      },
      child: BlocBuilder<SignupBloc, SignupState>(
        builder: (context, state) {
          print("👌👌👌👌👌👌Setear valores👌👌👌👌👌👌");
          print(state.model.name);
          print("👌👌👌👌👌👌Setear valores👌👌👌👌👌👌");
          usernameController.text = state.model.name;
          emailController.text = state.model.email;
          passwordController.text = state.model.password;
          confirmPasswordController.text = state.model.confirmPassword;
          imageController.text = state.model.imageUrl;

          final bool isValidForm =
              validateName(usernameController.text) == null &&
              validateEmail(emailController.text) == null &&
              validatePassword(passwordController.text) == null &&
              validateConfirmPassword(
                    passwordController.text,
                    confirmPasswordController.text,
                  ) ==
                  null &&
              validateURL(imageController.text) == null;

          return Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Registro de Usuarios",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: usernameController,
                  validator: validateName,
                  onChanged: (value) => bloc.add(NameChangedEvent(name: value)),
                  style: TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Nombre de usuario",
                    prefixIcon: Icon(Icons.person, color: Color(0xFF6F6758)),
                    hintText: "Nombre de usuario",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  validator: validateEmail,
                  onChanged:
                      (value) => bloc.add(EmailChangedEvent(email: value)),
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
                  validator: validatePassword,
                  onChanged:
                      (value) =>
                          bloc.add(PasswordChangedEvent(password: value)),
                  obscureText: !_showPassword,
                  style: TextStyle(fontSize: 14),

                  decoration: InputDecoration(
                    labelText: "Contraseña",
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
                    hintText: "Contraseña",
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: confirmPasswordController,
                  validator:
                      (value) => validateConfirmPassword(
                        value,
                        passwordController.text,
                      ),
                  onChanged:
                      (value) => bloc.add(
                        ConfirmPasswordChangedEvent(confirmPassword: value),
                      ),
                  obscureText: !_showConfirmPassword,
                  style: TextStyle(fontSize: 14),

                  decoration: InputDecoration(
                    labelText: "Confirmar Contraseña",
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
                        _showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: togglePasswordVisibilityConfirm,
                    ),
                    hintText: "Confirmar Contraseña",
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16.0),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: imageController,
                  validator: validateURL,
                  onChanged:
                      (value) =>
                          bloc.add(UrlImageChangedEvent(imageUrl: value)),
                  style: TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: "Imagen (URL)",
                    prefixIcon: Icon(Icons.link, color: Color(0xFF6F6758)),
                    hintText: "Imagen (URL)",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6F6758)),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed:
                          isValidForm ? () => bloc.add(SubmitEvent()) : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFFEF1D26,
                        ), // Color principal
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        "Registrarse",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    OutlinedButton(
                      onPressed:
                          () => GoRouter.of(
                            context,
                          ).pushReplacementNamed("login"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Text(
                        "Volver",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  ],
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
      barrierDismissible: false,
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
