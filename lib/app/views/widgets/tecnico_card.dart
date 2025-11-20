import 'package:flutter/material.dart';
import '../../controllers/Tecnico_controller.dart';
import '../../models/Tecnico_model.dart';
import '../../models/usuario_base_model.dart';
import 'edit_tecnico_widget.dart';

class TecnicoCard extends StatelessWidget {
  final TecnicoModel tecnico;
  final UsuarioBase user;
  final VoidCallback onUpdate;

  const TecnicoCard({
    super.key,
    required this.tecnico,
    required this.user,
    required this.onUpdate,
  });

  Future<bool> _deleteTecnico(BuildContext context) async {
    TecnicoController tecnicoController = TecnicoController(context: context);

    tecnicoController.apagarTecnico(idTecnico: tecnico.id!);

    tecnicoController.messenger.showSnackBar(
      SnackBar(content: Text('O técnico ${tecnico.nomeRazao} foi deletado.')),
    );
    onUpdate();

    tecnicoController.navigator.pop();

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        constraints: BoxConstraints(minHeight: 130),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID: ${tecnico.id} | ${tecnico.nomeRazao}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Email: ${tecnico.email} | Telefone: ${tecnico.telefone}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Divider(indent: 0, thickness: 1, height: 5),

                    Text(
                      getEspecialidades()
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 5,
                      softWrap: true,
                    ),
                  ],
                ),
              ),

              VerticalDivider(width: 7),

              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (user.cpfCnpj == '')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => EditTecnicoCard(
                                user: user,
                                tecnico: tecnico,
                                onUpdate: () {
                                  onUpdate();
                                },
                              ),
                            ),
                            icon: Icon(Icons.edit, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () async {
                              _showConfimation(context);
                            },
                            icon: Icon(Icons.delete, color: Colors.white),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<dynamic> getEspecialidades() {
    List<dynamic> especialidades = tecnico.especialidades!;
    var especialidadesFiltradas = [];
    for (int i = 0; i < especialidades.length; i++) {
      especialidadesFiltradas.add(especialidades[i]['nome']);
    }
    return especialidadesFiltradas;
  }

  void _showConfimation(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Quer apagar mesmo?'),
        content: const Text(
          'Se você clicar em apagar o técnico sera apagado permanentemente.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              await _deleteTecnico(context);
            },
            child: const Text('Apagar', style: TextStyle(color: Colors.red) ,),
          ),
        ],
      ),
    );
  }
}
