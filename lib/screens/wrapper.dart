import 'package:flutter/material.dart';
import 'package:milestones/models/user.dart';
import 'package:milestones/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    // Return either Auth or Home Screen
    return user != null ? const HomeScreen() : const Authenticate();
  }
}
