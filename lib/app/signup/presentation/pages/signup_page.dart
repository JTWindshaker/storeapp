import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool showPassword = false;
  bool showConfirmPassword = false;
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
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
                  bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
                        const Text(
                          "Registro",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        _buildImagePreview(),
                        const SizedBox(height: 16.0),
                        _buildTextField("Nombre de usuario", Icons.person),
                        const SizedBox(height: 16.0),
                        _buildTextField(
                          "Correo",
                          Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16.0),
                        _buildPasswordField("Contraseña", showPassword, () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                          if (showPassword) {
                            Future.delayed(const Duration(seconds: 3), () {
                              setState(() {
                                showPassword = false;
                              });
                            });
                          }
                        }),
                        const SizedBox(height: 16.0),
                        _buildPasswordField(
                          "Confirmar contraseña",
                          showConfirmPassword,
                          () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                            if (showConfirmPassword) {
                              Future.delayed(const Duration(seconds: 3), () {
                                setState(() {
                                  showConfirmPassword = false;
                                });
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        _buildImageUrlField(),
                        const SizedBox(height: 24.0),
                        _buildButtons(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      style: TextStyle(fontSize: 14),
      keyboardType: keyboardType,
    );
  }

  Widget _buildPasswordField(
    String label,
    bool isVisible,
    VoidCallback toggleVisibility,
  ) {
    return TextField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  Widget _buildImageUrlField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Imagen (URL)",
        prefixIcon: const Icon(Icons.link),
        suffixIcon: IconButton(
          icon: const Icon(Icons.image_search),
          onPressed: () => setState(() {}),
        ),
      ),
      onChanged: (value) {
        setState(() => imageUrl = value);
      },
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: 120,
        height: 120,
        color: Colors.grey[300],
        child:
            imageUrl.isNotEmpty
                ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _placeholder();
                  },
                )
                : _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return Center(
      child: Text("Sin Cargar...", style: TextStyle(color: Colors.grey[700])),
    );
  }

  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEF1D26), // Rojo (main)
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text(
            "Registrarse",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        const SizedBox(height: 12.0),
        OutlinedButton(
          onPressed: () => GoRouter.of(context).pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            side: const BorderSide(
              color: Color(0xFF6F6758),
            ), // Color secundario
          ),
          child: const Text(
            "Volver",
            style: TextStyle(fontSize: 16.0, color: Color(0xFF6F6758)),
          ),
        ),
      ],
    );
  }
}
