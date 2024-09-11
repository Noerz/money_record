// To parse this JSON data, do
//
//     final dompet = dompetFromJson(jsonString);

import 'dart:convert';

Dompet dompetFromJson(String str) => Dompet.fromJson(json.decode(str));

String dompetToJson(Dompet data) => json.encode(data.toJson());

class Dompet {
    final int idDompet;
    final String nama;
    final int target;
    final int saldo;
    final int userId;
    final DateTime createdAt;
    final DateTime updatedAt;

    Dompet({
        required this.idDompet,
        required this.nama,
        required this.target,
        required this.saldo,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Dompet.fromJson(Map<String, dynamic> json) => Dompet(
        idDompet: json["idDompet"],
        nama: json["nama"],
        target: json["target"],
        saldo: json["saldo"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "idDompet": idDompet,
        "nama": nama,
        "target": target,
        "saldo": saldo,
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
