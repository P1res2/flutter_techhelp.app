import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Theme.of(context).brightness == Brightness.light ? AppColors.backgroundLinearGradientLight : AppColors.backgroundLinearGradientDark,
        child: Column(
          children: [
            const SizedBox(height: 200),

            Image.asset("assets/images/techhelp_logo.png", scale: 4),

            const SizedBox(height: 200),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text("Começar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
