import 'package:cloud_firestore/cloud_firestore.dart';

class EncontroModel {
  final String id;
  final String cliente;
  final String telefone;
  final String servico;
  final DateTime data;

  EncontroModel({
    required this.id,
    required this.cliente,
    required this.telefone,
    required this.servico,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'cliente': cliente,
      'telefone': telefone,
      'servico': servico,
      'data': Timestamp.fromDate(data),
    };
  }

  factory EncontroModel.fromMap(String id, Map<String, dynamic> map) {
    final rawData = map['data'];

    return EncontroModel(
      id: id,
      cliente: map['cliente'] ?? '',
      telefone: map['telefone'] ?? '',
      servico: map['servico'] ?? '',
      data: rawData is Timestamp
          ? rawData.toDate()
          : DateTime.tryParse(rawData.toString()) ?? DateTime.now(),
    );
  }
}
