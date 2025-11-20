import 'package:flutter/material.dart';
import '../../controllers/Tecnico_controller.dart';
import '../../models/Tecnico_model.dart';
import '../../models/usuario_base_model.dart';


class EditTecnicoCard extends StatefulWidget {
  final UsuarioBase user;
  final TecnicoModel tecnico;
  final VoidCallback onUpdate;

  const EditTecnicoCard({
    super.key,
    required this.user,
    required this.tecnico,
    required this.onUpdate,
  });

  @override
  State<EditTecnicoCard> createState() => _EditTecnicoWidgetState();
}

class _EditTecnicoWidgetState extends State<EditTecnicoCard> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  String especialidadesController = 'Baixa';
  late bool _ativoController;
  late bool hardwareCheck;
  late bool softwareCheck;
  late bool redesCheck;
  late bool segurancaCheck;
  late bool sistemasOperacionaisCheck;
  late bool isLoading;

  void _closeWidget() {
    Navigator.pop(context);
  }

  List<dynamic> _getEspecialidades() {
    List<dynamic> especialidades = widget.tecnico.especialidades!;
    var especialidadesFiltradas = [];
    for (int i = 0; i < especialidades.length; i++) {
      especialidadesFiltradas.add(especialidades[i]['nome']);
    }
    setState(() {
      especialidadesFiltradas.contains('Hardware')
          ? hardwareCheck = true
          : hardwareCheck = false;
      especialidadesFiltradas.contains('Software')
          ? softwareCheck = true
          : softwareCheck = false;
      especialidadesFiltradas.contains('Redes')
          ? redesCheck = true
          : redesCheck = false;
      especialidadesFiltradas.contains('Seguranca')
          ? segurancaCheck = true
          : segurancaCheck = false;
      especialidadesFiltradas.contains('Sistemas Operacionais')
          ? sistemasOperacionaisCheck = true
          : sistemasOperacionaisCheck = false;
    });

    return especialidadesFiltradas;
  }

  List<int> getEspecialidadesIDs() {
    List<int> especialidadesIDs = [];

    if (hardwareCheck) especialidadesIDs.add(1);
    if (softwareCheck) especialidadesIDs.add(2);
    if (redesCheck) especialidadesIDs.add(3);
    if (segurancaCheck) especialidadesIDs.add(4);
    if (sistemasOperacionaisCheck) especialidadesIDs.add(5);

    return especialidadesIDs;
  }

  @override
  void initState() {
    super.initState();
    _nomeController.text = widget.tecnico.nomeRazao;
    _telefoneController.text = widget.tecnico.telefone;
    _ativoController = widget.tecnico.ativo!;
    _getEspecialidades();
  }

  @override
  Widget build(BuildContext context) {
    final TecnicoController tecnicoController = TecnicoController(
      context: context,
    );
    TextEditingController nome = TextEditingController(
      text: widget.tecnico.nomeRazao,
    );
    TextEditingController telefone = TextEditingController(
      text: widget.tecnico.telefone,
    );

    return Padding(
      padding: EdgeInsets.all(32),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Editar Tecnico", style: TextStyle(fontSize: 20)), // nome

              const SizedBox(height: 32), // Espaçamento

              ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: _ativoController
                          ? Text("Ativo")
                          : Text('Desativado'),
                      value: _ativoController,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? value) {
                        setState(() {
                          _ativoController = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16), // Espaçamento

              TextField(
                controller: nome,
                readOnly: true,
                decoration: InputDecoration(labelText: "Nome"),
              ),

              const SizedBox(height: 16), // Espaçamento

              TextField(
                controller: telefone,
                readOnly: true,
                decoration: InputDecoration(labelText: "Telefone"),
              ),

              const SizedBox(height: 16), // Espaçamento
              // ESPECIALIDADES:
              // Hardware
              ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text("Hardware"),
                      value: hardwareCheck,
                      controlAffinity: ListTileControlAffinity.leading,
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
                      controlAffinity: ListTileControlAffinity.leading,
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
                      controlAffinity: ListTileControlAffinity.leading,
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
                      controlAffinity: ListTileControlAffinity.leading,
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

              ElevatedButton(
                onPressed: () async {
                  // salva e fecha
                  if (await tecnicoController.editarTecnico({
                    "nome": _nomeController.text,
                    "telefone": _telefoneController.text,
                    "ids_especialidades": getEspecialidadesIDs(),
                  }, widget.tecnico.id!)) {
                    _closeWidget();
                    widget.onUpdate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tecnico editado com sucesso!')),
                    );
                  }
                },
                child: Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
