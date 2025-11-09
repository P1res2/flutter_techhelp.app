import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';

class TechhelpApp extends StatelessWidget {
  const TechhelpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TechHelp",
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.start,
      routes: appRoutes,
    );
  }
}
