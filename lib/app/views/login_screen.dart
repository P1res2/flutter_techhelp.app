import 'package:flutter/material.dart';
import 'widgets/textfields/email_textfield.dart';
import 'widgets/textfields/password_textfield.dart';
import '../utils/validators.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Validators validators = Validators(context: context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 200),

              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 350, minWidth: 200),
                  child: Column(
                    children: [
                      EmailTextfield(emailController: _emailController),

                      const SizedBox(height: 16), // ESPAÇAMENTO

                      PasswordTextfield(controller: _senhaController),

                      const SizedBox(height: 32), // ESPAÇAMENTO

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (!isLoading) {
                                Navigator.pushNamed(context, "/register");
                              }
                            },
                            child: const Text("Cadastrar-se"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Verifica se os campos estão preenchidos
                              if (_emailController.text.isEmpty ||
                                  _senhaController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Preencha todos os campos!'),
                                  ),
                                );
                                return;
                              }

                              // Valida o Email
                              if (!validators.emailValidation(
                                _emailController.text,
                              )) {
                                return;
                              }

                              // Efetua o login
                              _onButtonLoginClicked();
                            },
                            child: (isLoading)
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text("Entrar"),
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
      ),
    );
  }

  Future<void> _onButtonLoginClicked() async {
    final AuthController authController = AuthController(context: context);

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await authController.login(
        tipo: TipoUsuario.cliente,
        email: _emailController.text,
        password: _senhaController.text,
      );

      setState(() {
        isLoading = false;
      });
    }
  }
}
