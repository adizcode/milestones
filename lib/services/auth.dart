import 'package:milestones/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<firebase.UserCredential> signInAnon() async {
    return await _auth.signInAnonymously();
  }

  Future<firebase.UserCredential> registerWithEmail(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<firebase.UserCredential> signInWithEmail(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  User? _userFromFirebaseUser(firebase.User? user) {
    return user != null ? User(user.uid) : null;
  }
}
