import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends ChangeNotifier {
  final _auth = AuthService();
  bool carregando = false;

  String erroMensagem = '';

  Future<bool> login(String email, String senha) async {
    carregando = true;
    erroMensagem = '';
    notifyListeners();

    try {
      final user = await _auth.login(email, senha);
      return user != null;
    } on FirebaseAuthException catch (e) {
      erroMensagem = _tratarErroFirebase(e);
      print("ERRO NO LOGIN: ${e.code} - ${e.message}");
      return false;
    } catch (e) {
      erroMensagem = 'Erro desconhecido ao fazer login.';
      print("ERRO DESCONHECIDO NO LOGIN: $e");
      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<bool> registrar(String email, String senha) async {
    carregando = true;
    erroMensagem = '';
    notifyListeners();

    try {
      final user = await _auth.registrar(email, senha);
      return user != null;
    } on FirebaseAuthException catch (e) {
      erroMensagem = _tratarErroFirebase(e);
      print("ERRO NO CADASTRO: ${e.code} - ${e.message}");
      return false;
    } catch (e) {
      erroMensagem = 'Erro desconhecido ao cadastrar usuário.';
      print("ERRO DESCONHECIDO NO CADASTRO: $e");
      return false;
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Erro ao fazer logout: $e");
    }
  }

  String _tratarErroFirebase(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'E-mail inválido.';
      case 'user-disabled':
        return 'Usuário desabilitado.';
      case 'user-not-found':
        return 'Usuário não encontrado.';
      case 'wrong-password':
        return 'Senha incorreta.';
      case 'email-already-in-use':
        return 'E-mail já está em uso.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';
      case 'weak-password':
        return 'Senha muito fraca (mínimo 6 caracteres).';
      default:
        return 'Erro inesperado: ${e.message}';
    }
  }
}
