import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/utils/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:br_validators/br_validators.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Máscaras:
  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cnpjFormatter = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final AuthController _authController = AuthController();

  bool _isPessoaFisica = true;
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _accountType = "Fisica";

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senha1Controller = TextEditingController();
  final TextEditingController _senha2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

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
              icon: const Icon(Icons.arrow_back),
            ),
            const SizedBox(height: 200),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
                child: Column(
                  children: [
                    // Nome e telefone
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              label: Text("Nome"),
                            ),
                            controller: _nomeController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              label: Text("Telefone"),
                              hintText: "(00)90000-0000",
                            ),
                            controller: _telefoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // CPF/CNPJ e tipo de conta
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              label: Text(_isPessoaFisica ? "CPF" : "CNPJ"),
                            ),
                            controller: _cpfCnpjController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              _isPessoaFisica ? cpfFormatter : cnpjFormatter,
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButton<String>(
                            value: _accountType,
                            isExpanded: true,
                            items: tiposContas,
                            onChanged: (value) {
                              if (value != null && value.isNotEmpty) {
                                setState(() {
                                  _isPessoaFisica = value == "Fisica";
                                  _accountType = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Email
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              hintText: "exemplo@email.com",
                            ),
                            controller: _emailController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Senha e confirmar senha
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
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
                            controller: _senha1Controller,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            obscureText: !_showConfirmPassword,
                            decoration: InputDecoration(
                              label: const Text("Confirme a senha"),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPassword =
                                        !_showConfirmPassword;
                                  });
                                },
                                icon: Icon(
                                  _showConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            controller: _senha2Controller,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Botão cadastrar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Verifica se o número de telefone é válido
                            if (!BRValidators.validateMobileNumber(
                              _telefoneController.text,
                            )) {
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text("Número de telefone inválido!"),
                                ),
                              );
                            }

                            // Verifica se o Cpf/Cnpj é válido
                            if (_isPessoaFisica
                                ? !BRValidators.validateCPF(
                                    _cpfCnpjController.text,
                                  )
                                : !BRValidators.validateCNPJ(
                                    _cpfCnpjController.text,
                                  )) {
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    _isPessoaFisica
                                        ? "Cpf inválido!"
                                        : "Cnpj inválido!",
                                  ),
                                ),
                              );
                            }

                            // Verifica se o Email é válido
                            if (!_emailController.text.contains("@") ||
                                !_emailController.text.contains(".com")) {
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Email inválido!'),
                                ),
                              );
                            }

                            // Verifica se as senhas são iguais
                            if (_senha1Controller.text !=
                                _senha2Controller.text) {
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('As senhas devem ser iguais.'),
                                ),
                              );
                            }

                            // Verifica se todos os campos estão preenchidos
                            if (_nomeController.text.isEmpty ||
                                _telefoneController.text.isEmpty ||
                                _telefoneController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _senha1Controller.text.isEmpty ||
                                _senha2Controller.text.isEmpty) {
                              messenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Preencha todos os campos!'),
                                ),
                              );
                              return;
                            }

                            // Tenta registrar os dados passados
                            _authController.register(
                              context: context,
                              nomeRazao: _nomeController.text,
                              telefone: _telefoneController.text,
                              cpfCnpj: _cpfCnpjController.text,
                              tipo: _accountType,
                              email: _emailController.text,
                              password: _senha1Controller.text,
                            );
                          },
                          child: const Text("Cadastrar"),
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
