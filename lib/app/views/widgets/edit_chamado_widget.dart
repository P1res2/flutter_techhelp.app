import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/controllers/chamado_controller.dart';
import 'package:flutter_techhelp_app/app/models/chamado_model.dart';
import 'package:flutter_techhelp_app/app/models/usuario_base_model.dart';
import 'package:flutter_techhelp_app/app/utils/constants.dart' as c;
import 'package:flutter_techhelp_app/app/views/widgets/fields/app_dropdown_button_form_field.dart';

class EditChamadoCard extends StatefulWidget {
  final UsuarioBase user;
  final ChamadoModel chamado;
  final VoidCallback onUpdate;

  const EditChamadoCard({
    super.key,
    required this.user,
    required this.chamado,
    required this.onUpdate
  });

  @override
  State<EditChamadoCard> createState() => _EditChamadoWidgetState();
}

class _EditChamadoWidgetState extends State<EditChamadoCard> {
  late String prioridadeController;
  late String statusController;
  late String tipoAtendimentoController;
  late String categoriaController;

  final ChamadoController _chamadoController = ChamadoController();

  void _closeWidget() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    prioridadeController = widget.chamado.prioridade;
    statusController = widget.chamado.status!;
    tipoAtendimentoController = widget.chamado.tipoAtendimento;
    categoriaController = widget.chamado.categoria;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titulo = TextEditingController(
      text: widget.chamado.titulo,
    );
    TextEditingController descricao = TextEditingController(
      text: widget.chamado.descricao,
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
              Text("Editar chamado", style: TextStyle(fontSize: 20)), // Titulo

              const SizedBox(height: 32), // Espaçamento

              TextField(
                controller: titulo,
                readOnly: true,
                decoration: InputDecoration(labelText: "Título"),
              ),

              const SizedBox(height: 16), // Espaçamento

              TextField(
                controller: descricao,
                readOnly: true,
                maxLines: 4,
                decoration: InputDecoration(labelText: "Descrição"),
              ),

              const SizedBox(height: 16), // Espaçamento

              AppDropdownButtonFormField(
                title: 'Prioridades',
                value: prioridadeController,
                itens: c.prioridades,
                onChanged: (newValue) {
                  setState(() {
                    prioridadeController = newValue;
                  });
                },
              ),

              const SizedBox(height: 16), // Espaçamento

              AppDropdownButtonFormField(
                title: 'Status',
                value: statusController,
                itens: c.status,
                onChanged: (newValue) {
                  setState(() {
                    statusController = newValue;
                  });
                },
              ),

              const SizedBox(height: 16), // Espaçamento

              AppDropdownButtonFormField(
                title: 'Tipo de Atendimento',
                value: tipoAtendimentoController,
                itens: c.tiposAtendimentos,
                onChanged: (newValue) {
                  setState(() {
                    tipoAtendimentoController = newValue;
                  });
                },
              ),

              const SizedBox(height: 16), // Espaçamento

              AppDropdownButtonFormField(
                title: 'Categoria',
                value: categoriaController,
                itens: c.categorias,
                onChanged: (newValue) {
                  setState(() {
                    categoriaController = newValue;
                  });
                },
              ),

              const SizedBox(height: 16), // Espaçamento

              ElevatedButton(
                onPressed: () async {
                  // salva e fecha
                  if (await _chamadoController.editarChamado({
                    "prioridade": prioridadeController,
                    "status": statusController,
                    "tipo_atendimento": tipoAtendimentoController,
                    "categoria": categoriaController,
                  }, widget.chamado.idChamado!)) {
                    _closeWidget();
                    widget.onUpdate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Chamado editado com sucesso!')),
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
