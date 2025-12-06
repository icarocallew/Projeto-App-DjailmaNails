import 'package:flutter/material.dart';
import 'encontro_form_view.dart';

class ServicoView extends StatelessWidget {
  final List<String> servicos = [
    "Alongamento de Unha",
    "Manicure + Pedicure",
    "Blindagem",
    "Esmaltação em Gel",
    "Spa dos Pés",
    "Design de Sobrancelha",
  ];

   ServicoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdeef4),
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 2,
        title: const Text(
          "Escolha um Serviço",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: servicos.length,
        itemBuilder: (_, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              title: Text(
                servicos[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.pinkAccent,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EncontroFormView(
                      servicoSelecionado: servicos[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
