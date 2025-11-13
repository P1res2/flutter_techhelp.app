import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/models/chamado_model.dart';
import 'package:flutter_techhelp_app/app/models/usuario_base_model.dart';
import 'package:flutter_techhelp_app/app/utils/plataform_utils.dart';
import '../widgets/chamado_widget.dart';
import '../../services/api_service.dart';
import '../../utils/app_colors.dart';

enum Options { my, all }

class ChamadosList extends StatefulWidget {
  final UsuarioBase user;
  final Options options;

  const ChamadosList({super.key, required this.user, required this.options});

  @override
  State<ChamadosList> createState() => _ChamadosListState();
}

class _ChamadosListState extends State<ChamadosList> {
  late Future<List<ChamadoModel>> _futureGetAll;

  @override
  void initState() {
    super.initState();
    if (widget.options == Options.my) {
      _futureGetAll = !isTecnico()
          ? ApiService().getAll(
              '/Chamados/Cliente/${widget.user.cpfCnpj}',
              ChamadoModel.fromMap,
            )
          : ApiService().getAll(
              '/Chamados/Tecnico/${widget.user.id}',
              ChamadoModel.fromMap,
            );
    }
    if (widget.options == Options.all) {
      _futureGetAll = ApiService().getAll('/Chamados/', ChamadoModel.fromMap);
    }
  }

  Future<void> refreshGetAll() async {
    setState(() {
      if (widget.options == Options.my) {
        _futureGetAll = !isTecnico()
            ? ApiService().getAll(
                '/Chamados/Cliente/${widget.user.cpfCnpj}',
                ChamadoModel.fromMap,
              )
            : ApiService().getAll(
                '/Chamados/Tecnico/${widget.user.id}',
                ChamadoModel.fromMap,
              );
      }
      if (widget.options == Options.all) {
        _futureGetAll = ApiService().getAll('/Chamados/', ChamadoModel.fromMap);
      }
    });
    await _futureGetAll;
  }

  bool isTecnico() {
    return widget.user.cpfCnpj == '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.options == Options.my
                    ? "Meus Chamados"
                    : "Todos os Chamados",
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (!PlatformUtils.isMobile)
                IconButton(onPressed: refreshGetAll, icon: Icon(Icons.refresh)),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.accent,
              ),
              child: RefreshIndicator(
                onRefresh: refreshGetAll,
                child: FutureBuilder(
                  future: _futureGetAll,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                        return Center(child: CircularProgressIndicator());
                      case ConnectionState.done:
                        {
                          if (snapshot.data == null || snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                "Nenhum chamado encontrado",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            );
                          } else {
                            List<ChamadoModel> listChamados = snapshot.data!;
                            return ListView.builder(
                              itemCount: listChamados.length,
                              itemBuilder: (context, index) {
                                return ChamadoWidget(
                                  user: widget.user,
                                  chamado: listChamados[index],
                                );
                              },
                            );
                          }
                        }
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
