import 'package:milestones/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<firebase.UserCredential> signInAnon() {
    return _auth.signInAnonymously();
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  User? _userFromFirebaseUser(firebase.User? user) {
    return user != null ? User(user.uid) : null;
  }
}
