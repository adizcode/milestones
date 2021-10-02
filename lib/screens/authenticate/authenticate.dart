import 'package:flutter/material.dart';
import 'package:milestones/screens/authenticate/register.dart';

import 'login.dart';

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
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: SafeArea(
        child: showSignIn ? LoginScreen(toggleView: _toggleView) : RegisterScreen(toggleView: _toggleView),
      ),
    );
  }
}
