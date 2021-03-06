import 'package:flutter/material.dart';
import 'package:milestones/screens/authenticate/register/register.dart';

import 'login/login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void _toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? LoginScreen(toggleView: _toggleView)
        : RegisterScreen(toggleView: _toggleView);
  }
}
