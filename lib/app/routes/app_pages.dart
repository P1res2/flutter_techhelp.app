import 'package:flutter/widgets.dart';
import '../views/home_screen.dart';
import '../views/login_screen.dart';
import '../views/register_screen.dart';
import '../views/chatbot_screen.dart';
import 'app_routes.dart';

final Map<String, WidgetBuilder> appRoutes = {
  AppRoutes.home: (context) => HomeScreen(),
  AppRoutes.login: (context) => LoginScreen(),
  AppRoutes.register: (context) => RegisterScreen(),
  AppRoutes.chatbot: (context) => ChatbotScreen(),
};
