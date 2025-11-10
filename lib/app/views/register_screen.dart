import 'package:flutter/material.dart';
import 'widgets/textfields/cpf_cnpj_textfield.dart';
import 'widgets/textfields/email_textfield.dart';
import 'widgets/textfields/nome_textfield.dart';
import 'widgets/textfields/password_textfield.dart';
import 'widgets/textfields/telefone_textfield.dart';
import '../utils/validators.dart';
import '../views/widgets/account_type_dropdownbutton.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senha1Controller = TextEditingController();
  final TextEditingController _senha2Controller = TextEditingController();

  bool isLoading = false;
  bool _isPessoaFisica = true;
  String _accountType = "Fisica";

  @override
  Widget build(BuildContext context) {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
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
                      // CPF/CNPJ e tipo de conta
                      Row(
                        children: [
                          Expanded(
                            child: CpfCnpjTextField(
                              controller: _cpfCnpjController,
                              isPessoaFisica: _isPessoaFisica,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: AccountTypeDropdown(
                              value: _accountType,
                              onChanged: (newValue) {
                                setState(() {
                                  _accountType = newValue;
                                  _isPessoaFisica = newValue == "Fisica";
                                  _cpfCnpjController.clear();
                                });
                              },
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
                              emailController: _emailController,
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
                                    content: Text('Preencha todos os campos!'),
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

                              // Valida se o Cpf/Cnpj é válido
                              if (!validators.cpfCnpjValidation(
                                _isPessoaFisica,
                                _cpfCnpjController.text,
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
    );
  }

  Future<void> _onRegisterButtonClicked() async {
    final AuthController authController = AuthController(context: context);

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      await authController.register(
        tipo: TipoUsuario.cliente,
        sufixUrl: '/Clientes/',
        dados: {
          "nome_razao": _nomeController.text,
          "telefone": _telefoneController.text,
          "cpf_cnpj": _cpfCnpjController.text,
          "tipo": _accountType,
          "email": _emailController.text,
          "senha": _senha1Controller.text,
        },
      );

      setState(() {
        isLoading = false;
      });
    }
  }
}
