import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_viewmodel.dart';
import 'home_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmarSenha = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Criar Conta"),
        backgroundColor: Colors.pink[400],
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  "Djailma Nails",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[400],
                  ),
                ),
                const SizedBox(height: 32),

              
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    filled: true,
                    fillColor: Colors.pink[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.pink[400]),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) return "Digite um e-mail";
                    if (!valor.contains("@") || !valor.contains(".")) return "E-mail inválido";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo Senha
                TextFormField(
                  controller: senha,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    filled: true,
                    fillColor: Colors.pink[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.pink[400]),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.isEmpty) return "Digite uma senha";
                    if (valor.length < 6) return "A senha deve ter ao menos 6 caracteres";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

               
                TextFormField(
                  controller: confirmarSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirmar Senha",
                    filled: true,
                    fillColor: Colors.pink[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.pink[400]),
                  ),
                  validator: (valor) {
                    if (valor != senha.text) return "As senhas não coincidem";
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      bool ok = await auth.registrar(
                        email.text.trim(),
                        senha.text.trim(),
                      );

                      if (ok) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeView()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(auth.erroMensagem),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: auth.carregando
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Cadastrar",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                const SizedBox(height: 16),

               
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Já tem uma conta? Entrar",
                    style: TextStyle(color: Colors.pink[400]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
