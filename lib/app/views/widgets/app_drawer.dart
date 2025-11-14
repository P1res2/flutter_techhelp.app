import 'package:flutter/material.dart';
import '../../controllers/auth_controller.dart';
import '../../models/usuario_base_model.dart';
import 'item_drawer.dart';

class AppDrawer extends StatelessWidget {
  final List<ItemDrawer> itens;
  final UsuarioBase user;

  const AppDrawer({super.key, required this.user, required this.itens});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController(context: context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Parte de cima
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nomeRazao.split(' ').first,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        user.cpfCnpj == ''
                            ? user.id! == 1
                                  ? 'Técnico Admin'
                                  : 'Técnico'
                            : 'Cliente',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ...itens, // Carregas os itens do drawer
              ],
            ),
          ),

          // Parte de baixo (fixa)
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              authController.logout();
            },
          ),
        ],
      ),
    );
  }
}
