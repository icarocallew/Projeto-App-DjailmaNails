import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/encontro_viewmodel.dart';
import 'encontro_form_view.dart';

class EncontroListaView extends StatelessWidget {
  const EncontroListaView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EncontroViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Agendamentos")),
    floatingActionButton: FloatingActionButton(
  child: const Icon(Icons.add),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EncontroFormView(
          servicoSelecionado: "Serviço", 
        ),
      ),
    );
  },
),

      body: StreamBuilder(
        stream: vm.listar(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final lista = snapshot.data!;
          if (lista.isEmpty) return const Center(child: Text("Nenhum agendamento."));

          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (_, i) {
              final e = lista[i];
              return ListTile(
                title: Text(e.cliente),
                subtitle: Text("${e.servico} - ${e.data.day}/${e.data.month}"),
              );
            },
          );
        },
      ),
    );
  }
}
