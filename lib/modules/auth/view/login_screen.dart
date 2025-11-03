import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            SizedBox(height: 200),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 350, minWidth: 200),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        label: Text("Email"),
                        hintText: "Exemplo@email.com",
                      ),
                    ),
                    SizedBox(height: 16), // ESPAÇAMENTO
                    TextField(
                      decoration: InputDecoration(label: Text("Senha")),
                      obscureText: true,
                    ),
                    SizedBox(height: 32), // ESPAÇAMENTO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "register");
                          },
                          child: Text("Cadastrar-se"),
                        ),
                        ElevatedButton(onPressed: () {}, child: Text("Entrar")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
