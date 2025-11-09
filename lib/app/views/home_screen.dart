import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../views/widgets/chamados_list.dart';
import '../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController(context: context);
    final usuario =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text("TechHelp"),
        leading: IconButton(
          onPressed: authController.logout,
          icon: Icon(Icons.logout),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(color: AppColors.accent, child: Column()),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(64.0),
              child: ChamadosList(user: usuario),
            ),
          ),
        ],
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
