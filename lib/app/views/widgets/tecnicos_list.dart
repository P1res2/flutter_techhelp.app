import 'package:flutter/material.dart';
import 'package:flutter_techhelp_app/app/models/Tecnico_model.dart';
import 'package:flutter_techhelp_app/app/models/usuario_base_model.dart';
import 'package:flutter_techhelp_app/app/utils/plataform_utils.dart';
import '../../services/api_service.dart';
import '../../utils/app_colors.dart';
import 'tecnico_card.dart';

class TecnicosList extends StatefulWidget {
  final UsuarioBase user;

  const TecnicosList({super.key, required this.user});

  @override
  State<TecnicosList> createState() => _TecnicosListState();
}

class _TecnicosListState extends State<TecnicosList> {
  late Future<List<TecnicoModel>> _futureGetAll;

  @override
  void didUpdateWidget(covariant TecnicosList oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      refreshGetAll();
    });
  }

  @override
  void initState() {
    super.initState();

    _futureGetAll = ApiService().getAll(
      '/Tecnicos/',
      TecnicoModel.fromMapWithId,
    );
  }

  Future<void> refreshGetAll() async {
    setState(() {
      _futureGetAll = ApiService().getAll(
        '/Tecnicos/',
        TecnicoModel.fromMapWithId,
      );
    });
    await _futureGetAll;
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
                "Tecnicos",
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
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Nenhum Tecnico encontrado",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                  if (PlatformUtils.isMobile)
                                    IconButton(
                                      onPressed: refreshGetAll,
                                      icon: Icon(Icons.refresh),
                                    ),
                                ],
                              ),
                            );
                          } else {
                            List<TecnicoModel> listTecnicos = snapshot.data!;
                            return ListView.builder(
                              itemCount: listTecnicos.length,
                              itemBuilder: (context, index) {
                                return TecnicoCard(
                                  user: widget.user,
                                  tecnico: listTecnicos[index],
                                  onUpdate: () {
                                    refreshGetAll();
                                  },
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
