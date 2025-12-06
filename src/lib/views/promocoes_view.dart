import 'package:flutter/material.dart';

class PromocoesView extends StatelessWidget {
  const PromocoesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promoções"),
        backgroundColor: Colors.pink[400],
      ),
      body: const Center(
        child: Text("Tela de Promoções"),
      ),
    );
  }
}
