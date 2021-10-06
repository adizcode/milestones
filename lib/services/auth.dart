import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:milestones/models/user.dart';

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
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on firebase.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Please enter a valid email';
        case 'email-already-in-use':
          throw 'This email is already in use';
        case 'weak-password':
          throw 'This password is too weak';
        default:
          throw 'Whoops! Something\'s not quite right!';
      }
    }
  }

  Future<firebase.UserCredential> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase.FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw 'Please enter a valid email';
        case 'user-disabled':
          throw 'This user has been disabled\nPlease contact the developer';
        case 'user-not-found':
          throw 'It looks like you\'re new here\nPlease register yourself';
        case 'wrong-password':
          throw 'The password does not match\nAre you sure you\'ve typed it correctly?';
        default:
          throw 'Whoops! Something\'s not quite right!';
      }
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  User? _userFromFirebaseUser(firebase.User? user) {
    return user != null ? User(user.uid) : null;
  }
}
