import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/encontro_viewmodel.dart';
import '../models/encontro_model.dart';

class EncontroFormView extends StatelessWidget {
  final String servicoSelecionado;

  EncontroFormView({super.key, required this.servicoSelecionado});

  final nome = TextEditingController();
  final telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EncontroViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Agendamento"),
        backgroundColor: Colors.pinkAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nome,
              decoration: const InputDecoration(
                labelText: "Nome do Cliente",
              ),
            ),

            TextField(
              controller: telefone,
              decoration: const InputDecoration(
                labelText: "Telefone",
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Serviço selecionado:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent,
                fontSize: 18,
              ),
            ),

            Text(
              servicoSelecionado,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
              ),
              onPressed: () {
                final e = EncontroModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  cliente: nome.text,
                  telefone: telefone.text,
                  servico: servicoSelecionado,
                  data: DateTime.now(),
                );

                vm.salvar(e);
                Navigator.pop(context);
              },
              child: const Text(
                "Salvar Agendamento",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
