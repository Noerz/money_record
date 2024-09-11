// To parse this JSON data, do
//
//     final transaksi = transaksiFromJson(jsonString);

import 'dart:convert';

Transaksi transaksiFromJson(String str) => Transaksi.fromJson(json.decode(str));

String transaksiToJson(Transaksi data) => json.encode(data.toJson());

class Transaksi {
  final int? idTransaksi;
  final String namaTransaksi;
  final DateTime tanggal;
  final int jumlah;
  final String? jenis;
  final String keterangan;
  final int dompetId;
  final int idKategori;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Transaksi({
    this.idTransaksi,
    required this.namaTransaksi,
    required this.tanggal,
    required this.jumlah,
    this.jenis,
    required this.keterangan,
    required this.dompetId,
    required this.idKategori,
    this.createdAt,
    this.updatedAt,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
        idTransaksi: json["idTransaksi"],
        namaTransaksi: json["namaTransaksi"],
        tanggal: DateTime.parse(json["tanggal"]),
        jumlah: json["jumlah"],
        jenis: json["jenis"],
        keterangan: json["keterangan"],
        dompetId: json["dompet_id"],
        idKategori: json["idKategori"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idTransaksi": idTransaksi,
        "namaTransaksi": namaTransaksi,
        "tanggal": tanggal.toIso8601String(),
        "jumlah": jumlah,
        "jenis": jenis,
        "keterangan": keterangan,
        "dompet_id": dompetId,
        "idKategori": idKategori,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
