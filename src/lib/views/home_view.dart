import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/auth_viewmodel.dart';
import 'login_view.dart';
import 'servico_view.dart';
import 'agendamentos_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Djailma Nails",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginView()),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("Faça login para continuar.");
                }

                final user = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bem-vindo!",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Logado como: ${user.email}"),
                  ],
                );
              },
            ),

            const SizedBox(height: 32),

            _buildCard(
              title: "Agendar Serviço",
              icon: Icons.calendar_today,
              background: Colors.pink[100]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ServicoView()),
                );
              },
            ),

            const SizedBox(height: 16),

            _buildCard(
              title: "Meus Agendamentos",
              icon: Icons.list_alt,
              background: Colors.pink[50]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MeusAgendamentosView()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color background,
    required VoidCallback onTap,
  }) {
    return Material(
      color: background,
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: Colors.pinkAccent, size: 32),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
