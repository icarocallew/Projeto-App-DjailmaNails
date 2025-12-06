import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_viewmodel.dart';
import 'home_view.dart';
import 'register_view.dart';

class LoginView extends StatelessWidget {
  final email = TextEditingController();
  final senha = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TÍTULO
              const Text(
                "Djailma Nails",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE91E63),
                ),
              ),
              const SizedBox(height: 30),

              // CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE91E63)),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: senha,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE91E63)),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // BOTÃO LOGIN
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: auth.carregando
                            ? null
                            : () async {
                                bool ok = await auth.login(
                                  email.text.trim(),
                                  senha.text.trim(),
                                );

                                if (ok) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomeView()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("E-mail ou senha incorretos."),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE91E63),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: auth.carregando
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Entrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterView()),
                  );
                },
                child: const Text(
                  "Criar conta",
                  style: TextStyle(
                    color: Color(0xFFE91E63),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
