import 'dart:convert';

class Kuliner {
  final String id;
  final String nama;
  final String lokasi;
  final String notelp;
  final String note;

  Kuliner({
    required this.id,
    required this.nama,
    required this.lokasi,
    required this.notelp,
    required this.note,
  });

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    if (!map.containsKey('id') || !map.containsKey('nama') || !map.containsKey('lokasi') || !map.containsKey('notelp') || !map.containsKey('note')) {
      throw Exception("Missing keys in the JSON");
    }
    return Kuliner(
      id: map['id'].toString(),
      nama: map['nama'].toString(),
      lokasi: map['lokasi'].toString(),
      notelp: map['notelp'].toString(),
      note: map['note'].toString(),
    );
  }

  factory Kuliner.fromJson(String source) => Kuliner.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'lokasi': lokasi,
      'notelp': notelp,
      'note': note,
    };
  }

  String toJson() => json.encode(toMap());
}