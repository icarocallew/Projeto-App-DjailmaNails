import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> salvar(String colecao, String id, Map<String, dynamic> dados) {
    return _db.collection(colecao).doc(id).set(dados);
  }

  Future<void> deletar(String colecao, String id) {
    return _db.collection(colecao).doc(id).delete();
  }

  Stream<List<Map<String, dynamic>>> listar(String colecao) {
    return _db.collection(colecao).snapshots().map(
      (snap) {
        return snap.docs.map((d) {
          return {
            'id': d.id,
            ...d.data(),
          };
        }).toList();
      },
    );
  }
}
