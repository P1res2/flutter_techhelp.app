import 'package:flutter/material.dart';

class EditChamadoWidget extends StatelessWidget {
  const EditChamadoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Editar chamado", style: TextStyle(fontSize: 20)),
            TextField(decoration: InputDecoration(labelText: "Título")),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: "Descrição")),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // salva e fecha
                Navigator.pop(context);
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
