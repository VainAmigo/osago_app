import 'package:flutter/material.dart';
import 'package:osago_bloc_app/features/auth/presentation/pages/register/register_page.dart';

import 'login/login_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  // toggle between pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage( togglePage: togglePages,);
    } else {
      return RegisterPage( togglePage: togglePages,);
    }
  }
}
