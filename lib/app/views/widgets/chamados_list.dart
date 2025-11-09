import 'package:flutter/material.dart';
import '../widgets/chamado_widget.dart';
import '../../services/api_service.dart';
import '../../utils/app_colors.dart';

class ChamadosList extends StatefulWidget {
  final Map<dynamic, dynamic> user;

  const ChamadosList({super.key, required this.user});

  @override
  State<ChamadosList> createState() => _ChamadosListState();
}

class _ChamadosListState extends State<ChamadosList> {
  late Future<List<dynamic>> _futureGetAll;

  @override
  void initState() {
    super.initState();
    _futureGetAll = ApiService().getAll(
      "/Chamados/Cliente/${widget.user["id_cliente"]}",
    );
  }

  Future<void> refreshGetAll() async {
    setState(() {
      _futureGetAll = ApiService().getAll(
        "/Chamados/Cliente/${widget.user["id_cliente"]}",
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
                "Meus Chamados",
                style: TextStyle(color: AppColors.text, fontSize: 32, fontWeight: FontWeight.w500),
              ),
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
                              child: Text("Nenhum chamado encontrado", style: TextStyle(color: Colors.white, fontSize: 24),),
                            );
                          } else {
                            List<dynamic> listAccounts = snapshot.data!;
                            return ListView.builder(
                              itemCount: listAccounts.length,
                              itemBuilder: (context, index) {
                                return ChamadoWidget(
                                  chamado: listAccounts[index],
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
