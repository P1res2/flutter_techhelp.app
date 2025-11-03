import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_techhelp_app/core/constants.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String _accountType = "Fisica";
  bool _isPessoaFisica = true;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

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
                            decoration: const InputDecoration(label: Text("Nome")),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              label: Text("Telefone"),
                              hintText: "(99) 91234-5678",
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [phoneFormatter],
                          ),
                        ),
                      ],
                    ),

                    // CPF/CNPJ e tipo de conta
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              label: Text(_isPessoaFisica ? "CPF" : "CNPJ"),
                            ),
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

                    // Email
                    TextField(
                      decoration: const InputDecoration(
                        label: Text("Email"),
                        hintText: "exemplo@email.com",
                      ),
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
                                    _showConfirmPassword = !_showConfirmPassword;
                                  });
                                },
                                icon: Icon(
                                  _showConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
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
                          onPressed: () {},
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
