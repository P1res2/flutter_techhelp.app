import 'package:flutter/material.dart';
import '../models/usuario_base_model.dart';
import '../utils/plataform_utils.dart';
import './widgets/chamados_list.dart';
import './widgets/item_drawer.dart';
import './widgets/app_drawer.dart';
import './profile_screen.dart';
import './register_tecnico_screen.dart';
import 'widgets/tecnicos_list.dart';

class HomeTecnicoScreen extends StatefulWidget {
  const HomeTecnicoScreen({super.key});

  @override
  State<HomeTecnicoScreen> createState() => _HomeTecnicoScreenState();
}

// Páginas
enum HomeTecnicoPages { perfil, meusChamados, todosChamados, todosTecnicos, criarTecnicos }

class _HomeTecnicoScreenState extends State<HomeTecnicoScreen> {
  HomeTecnicoPages _selected = HomeTecnicoPages.todosChamados;

  Widget _getScreen(HomeTecnicoPages page, UsuarioBase usuario) {
    switch (page) {
      // Tela de perfil
      case HomeTecnicoPages.perfil:
        return ProfileScreen(user: usuario);
      // Tela de meus chamados
      case HomeTecnicoPages.meusChamados:
        return ChamadosList(user: usuario, options: Options.my);
      // Tela de todos os chamados
      case HomeTecnicoPages.todosChamados:
        return ChamadosList(user: usuario, options: Options.all);

      case HomeTecnicoPages.todosTecnicos:
      return TecnicosList(user: usuario);

      // tela de criar técnico
      case HomeTecnicoPages.criarTecnicos:
        return RegisterTecnicoScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuario = ModalRoute.of(context)!.settings.arguments as UsuarioBase;
    final isAdmin = usuario.id == 1;

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
            text: isAdmin ? 'Todos os Chamados' : 'Chamados',
            setUpdate: () => setState(() {
              _selected = HomeTecnicoPages.todosChamados;
            }),
          ),
          if (isAdmin)
            ItemDrawer(
              icon: Icons.person_search,
              text: 'Técnicos',
              setUpdate: () => setState(() {
                _selected = HomeTecnicoPages.todosTecnicos;
              }),
            ),
          if (isAdmin)
            ItemDrawer(
              icon: Icons.person_add,
              text: 'Criar técnico',
              setUpdate: () => setState(() {
                _selected = HomeTecnicoPages.criarTecnicos;
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
