import 'package:flutter/material.dart';
import '../models/usuario_base_model.dart';
import '../utils/plataform_utils.dart';
import '../views/widgets/chamados_list.dart';
import 'widgets/app_drawer.dart';
import 'widgets/item_drawer.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum HomePages { perfil, meusChamados } // paginas

class _HomeScreenState extends State<HomeScreen> {
  HomePages _selected = HomePages.meusChamados;

  Widget _getScreen(HomePages page, UsuarioBase usuario) {
    switch (page) {
      case HomePages.perfil:
        return ProfileScreen(user: usuario);
      case HomePages.meusChamados:
        return ChamadosList(
          user: usuario,
          options: Options.my,
        );
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
              _selected = HomePages.perfil;
            }),
          ),
          ItemDrawer(
            icon: Icons.list,
            text: 'Meus Chamados',
            setUpdate: () => setState(() {
              _selected = HomePages.meusChamados;
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
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Chamado"),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/chatbot', arguments: usuario);
        },
      ),
    );
  }
}
