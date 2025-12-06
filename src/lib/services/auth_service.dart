import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String senha) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return result.user;
  }


  Future<User?> registrar(String email, String senha) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
    return result.user;
  }

  Future<void> logout() => _auth.signOut();

  Stream<User?> get usuarioStream => _auth.authStateChanges();
}

