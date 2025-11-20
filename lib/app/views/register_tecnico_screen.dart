import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../utils/validators.dart';
import 'widgets/fields/email_textfield.dart';
import 'widgets/fields/nome_textfield.dart';
import 'widgets/fields/password_textfield.dart';
import 'widgets/fields/telefone_textfield.dart';

class RegisterTecnicoScreen extends StatefulWidget {
  const RegisterTecnicoScreen({super.key});

  @override
  State<RegisterTecnicoScreen> createState() => _RegisterTecnicoScreenState();
}

class _RegisterTecnicoScreenState extends State<RegisterTecnicoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senha1Controller = TextEditingController();
  final TextEditingController _senha2Controller = TextEditingController();

  bool hardwareCheck = false;
  bool softwareCheck = false;
  bool redesCheck = false;
  bool segurancaCheck = false;
  bool sistemasOperacionaisCheck = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    final Validators validators = Validators(context: context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                      minWidth: 200,
                    ),
                    child: Column(
                      children: [
                        // Nome e telefone
                        Row(
                          children: [
                            Expanded(
                              child: NomeTextfield(controller: _nomeController),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TelefoneTextfield(
                                controller: _telefoneController,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16), // Espaçamento
                        // Email
                        Row(
                          children: [
                            Expanded(
                              child: EmailTextfield(
                                controller: _emailController,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16), // Espaçamento
                        // Senha e confirmar senha
                        Row(
                          children: [
                            Expanded(
                              child: PasswordTextfield(
                                controller: _senha1Controller,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: PasswordTextfield(
                                controller: _senha2Controller,
                              ),
                            ),
                          ],
                        ),

                        // ESPECIALIDADES:
                        // Hardware
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Hardware"),
                                value: hardwareCheck,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    hardwareCheck = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Software
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Software"),
                                value: softwareCheck,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    softwareCheck = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Redes
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Redes"),
                                value: redesCheck,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    redesCheck = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Segurança
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Segurança"),
                                value: segurancaCheck,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    segurancaCheck = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Sistemas Operacionais
                        ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            children: [
                              CheckboxListTile(
                                title: Text("Sistemas Operacionais"),
                                value: sistemasOperacionaisCheck,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (bool? value) {
                                  setState(() {
                                    sistemasOperacionaisCheck = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32), // Espaçamento
                        // Botão cadastrar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // VALIDAÇÕES:
                                // Valida se todos os campos estão preenchidos
                                if (_nomeController.text.isEmpty ||
                                    _telefoneController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _senha1Controller.text.isEmpty ||
                                    _senha2Controller.text.isEmpty) {
                                  messenger.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Preencha todos os campos!',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                // Valida se o número de telefone é válido
                                if (!validators.phoneValidation(
                                  _telefoneController.text,
                                )) {
                                  return;
                                }

                                // Valida se o Email é válido
                                if (!validators.emailValidation(
                                  _emailController.text,
                                )) {
                                  return;
                                }

                                // Valida se as senhas são iguais
                                if (!validators.samePasswordValidation(
                                  _senha1Controller.text,
                                  _senha2Controller.text,
                                )) {
                                  return;
                                }

                                // Registra os dados passados
                                _onRegisterButtonClicked();
                              },
                              child: (isLoading)
                                  ? SizedBox(
                                      width: 21,
                                      height: 21,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("Cadastrar"),
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
      ),
    );
  }

  Future<void> _onRegisterButtonClicked() async {
    final AuthController authController = AuthController(context: context);

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      if (await authController.register(
        tipo: TipoUsuario.tecnico,
        sufixUrl: '/Tecnicos/',
        dados: {
          "nome": _nomeController.text.trim(),
          "email": _emailController.text.trim().toLowerCase(),
          "telefone": _telefoneController.text,
          "senha": _senha1Controller.text.trim(),
          "ids_especialidades": _getEspecialidadesIDs(),
        },
      )) {
        setState(() {
          _nomeController.clear();
          _emailController.clear();
          _telefoneController.clear();
          _senha1Controller.clear();
          _senha2Controller.clear();
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  List<int> _getEspecialidadesIDs() {
    List<int> ids = [];

    hardwareCheck == true ? ids.add(1) : '';
    softwareCheck == true ? ids.add(2) : '';
    redesCheck == true ? ids.add(3) : '';
    segurancaCheck == true ? ids.add(4) : '';
    sistemasOperacionaisCheck == true ? ids.add(5) : '';
    
    return ids;
  }
}
