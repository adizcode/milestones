import 'package:flutter/material.dart';
import 'package:milestones/services/auth.dart';

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign In Anonymously'),
          onPressed: () async {
            await AuthService().signInAnon();
          },
        ),
      ),
    );
  }
}
