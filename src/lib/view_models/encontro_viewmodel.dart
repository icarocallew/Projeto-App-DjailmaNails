import 'package:flutter/material.dart';
import '../models/encontro_model.dart';
import '../services/firestore_service.dart';

class EncontroViewModel extends ChangeNotifier {
  final _db = FirestoreService();
  final String colecao = "encontros";

  Stream<List<EncontroModel>> listar() {
    return _db.listar(colecao).map(
      (lista) {
        return lista.map(
          (item) {
            return EncontroModel.fromMap(
              item['id'],
              Map<String, dynamic>.from(item),
            );
          },
        ).toList();
      },
    );
  }

  Future<void> salvar(EncontroModel e) {
    return _db.salvar(colecao, e.id, e.toMap());
  }

  Future<void> deletar(String id) => _db.deletar(colecao, id);
}
