import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/encontro_viewmodel.dart';
import '../models/encontro_model.dart';

class MeusAgendamentosView extends StatelessWidget {
  const MeusAgendamentosView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EncontroViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Agendamentos"),
        backgroundColor: Colors.pinkAccent,
      ),

      body: StreamBuilder<List<EncontroModel>>(
        stream: vm.listar(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum agendamento encontrado.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final lista = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final e = lista[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(
                    e.servico,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  subtitle: Text("${e.cliente} • ${e.telefone}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${e.data.day}/${e.data.month}/${e.data.year}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),

                      // 🔥 BOTÃO DE CANCELAR
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () async {
                          await vm.deletar(e.id);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Agendamento cancelado!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
