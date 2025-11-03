import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            SizedBox(height: 200),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 350, minWidth: 200),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        label: Text("Email"),
                        hintText: "Exemplo@email.com",
                      ),
                      controller: _emailController,
                    ),
                    SizedBox(height: 16), // ESPAÇAMENTO
                    TextField(
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        label: const Text("Senha"),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      controller: _senhaController,
                    ),
                    SizedBox(height: 32), // ESPAÇAMENTO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/register");
                          },
                          child: Text("Cadastrar-se"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Valida o Email
                            if (!_emailController.text.contains("@") ||
                                !_emailController.text.contains(".com")) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email inválido!'),
                                ),
                              );
                              return;
                            }

                            _authController.login(
                              context: context,
                              email: _emailController.text,
                              password: _senhaController.text,
                            );
                          },
                          child: Text("Entrar"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
