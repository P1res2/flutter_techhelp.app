import 'package:flutter/material.dart';
import '../views/profile_screen.dart';
import '../views/widgets/app_drawer.dart';
import '../views/widgets/item_drawer.dart';
import '../models/usuario_base_model.dart';
import '../utils/plataform_utils.dart';
import 'widgets/chamados_list.dart';

class HomeTecnicoScreen extends StatefulWidget {
  const HomeTecnicoScreen({super.key});

  @override
  State<HomeTecnicoScreen> createState() => _HomeTecnicoScreenState();
}

enum HomeTecnicoPages { perfil, meusChamados, todosChamados } // Páginas

class _HomeTecnicoScreenState extends State<HomeTecnicoScreen> {
  HomeTecnicoPages _selected = HomeTecnicoPages.todosChamados;

  Widget _getScreen(HomeTecnicoPages page, UsuarioBase usuario) {
    switch (page) {
      case HomeTecnicoPages.perfil:
        return ProfileScreen(user: usuario);
      case HomeTecnicoPages.meusChamados:
        return ChamadosList(user: usuario, options: Options.my);
      case HomeTecnicoPages.todosChamados:
        return ChamadosList(user: usuario, options: Options.all);
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ModalRoute.of(context)!.settings.arguments as UsuarioBase;

    return Scaffold(
      appBar: AppBar(title: Text('TechHelp')),
      drawer: AppDrawer(
        user: usuario,
        itens: [
          ItemDrawer(
            icon: Icons.person,
            text: 'Perfil',
            setUpdate: () => setState(() {
              _selected = HomeTecnicoPages.perfil;
            }),
          ),
          ItemDrawer(
            icon: Icons.list,
            text: 'Meus Chamados',
            setUpdate: () => setState(() {
              _selected = HomeTecnicoPages.meusChamados;
            }),
          ),
          ItemDrawer(
            icon: Icons.add,
            text: 'Todos os Chamados',
            setUpdate: () => setState(() {
              _selected = HomeTecnicoPages.todosChamados;
            }),
          ),
        ],
      ),
      body: Padding(
        padding: (PlatformUtils.isMobile)
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.all(64.0),
        child: _getScreen(_selected, usuario),
      ),
    );
  }
}
