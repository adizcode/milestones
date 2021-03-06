import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:milestones/models/user.dart';
import 'package:milestones/screens/wrapper.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

// This widget is the root of your application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FirebaseFutureBuilder(),
        );
      },
    );
  }
}

// Widget to wait for a FirebaseApp instance to get initialized
class FirebaseFutureBuilder extends StatefulWidget {
  const FirebaseFutureBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<FirebaseFutureBuilder> createState() => _FirebaseFutureBuilderState();
}

class _FirebaseFutureBuilderState extends State<FirebaseFutureBuilder> {
  final Future<FirebaseApp> _initialization = Future.delayed(
    loaderDuration,
    () => Firebase.initializeApp(),
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Display error widget
          return const Text('Oops. I think I\'m kinda stuck :(');
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
            initialData: null,
            value: AuthService().user,
            child: const Wrapper(),
          );
        }

        return const Loader();
      },
    );
  }
}
