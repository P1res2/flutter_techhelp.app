import 'package:flutter/material.dart';
import '../controllers/cliente_controller.dart';
import '../controllers/tecnico_controller.dart';
import '../views/widgets/textfields/password_textfield.dart';
import '../views/widgets/textfields/nome_textfield.dart';
import 'widgets/textfields/email_textfield.dart';
import '../models/usuario_base_model.dart';
import '../utils/plataform_utils.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onUpdate;

  final UsuarioBase? user;

  const ProfileScreen({super.key, this.user, this.onUpdate});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nomeController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _senhaController = TextEditingController();

  bool editing = false;

  @override
  Widget build(BuildContext context) {
    final ClienteController clienteController = ClienteController(
      context: context,
    );
    final TecnicoController tecnicoController = TecnicoController(
      context: context,
    );
    _nomeController.text = widget.user!.nomeRazao;
    _emailController.text = widget.user!.email;
    _senhaController.text = widget.user!.password;
    // _telefoneController.text = user!.telefone;

    return Center(
      child: SizedBox(
        height: (PlatformUtils.isMobile)
            ? MediaQuery.of(context).size.height * 0.75
            : MediaQuery.of(context).size.height * 0.75,
        width: (PlatformUtils.isMobile)
            ? MediaQuery.of(context).size.height * 0.9
            : MediaQuery.of(context).size.height * 0.9,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black26,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(),
                      Column(
                        children: [
                          Text(
                            widget.user!.cpfCnpj == '' ? "Técnico" : "Cliente",
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.person, size: 128),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            editing = !editing;
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ],
                  ),

                  Divider(color: Colors.black),

                  const SizedBox(height: 16), // Espaçamento

                  NomeTextfield(
                    controller: _nomeController,
                    readOnly: !editing,
                  ),

                  const SizedBox(height: 16), // Espaçamento

                  EmailTextfield(
                    controller: _emailController,
                    readOnly: !editing,
                  ),

                  const SizedBox(height: 16), // Espaçamento

                  PasswordTextfield(
                    controller: _senhaController,
                    readOnly: !editing,
                  ),

                  const SizedBox(height: 32), // Espaçamento

                  editing
                      ? ElevatedButton(
                          onPressed: () async {
                            if (widget.user!.cpfCnpj == '') {
                              await tecnicoController.atualizarTecnico(
                                idTecnico: widget.user!.id!,
                                map: {
                                  "nome": _nomeController.text,
                                  "email": _emailController.text,
                                  "senha": _senhaController.text,
                                },
                              );
                            } else {
                              await clienteController.atualizarCliente(
                                idCliente: widget.user!.id!,
                                map: {
                                  "nome_razao": _nomeController.text,
                                  "email": _emailController.text,
                                  // "telefone": _telefoneController.text,
                                  "senha": _senhaController.text,
                                },
                              );
                            }
                          },
                          child: Text('Salvar'),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
