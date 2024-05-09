// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  final String nama;
  final String lokasi;
  final String notelp;
  final String note;
  Kuliner({
    required this.nama,
    required this.lokasi,
    required this.notelp,
    required this.note,
  });

  Kuliner copyWith({
    String? nama,
    String? lokasi,
    String? notelp,
    String? note,
  }) {
    return Kuliner(
      nama: nama ?? this.nama,
      lokasi: lokasi ?? this.lokasi,
      notelp: notelp ?? this.notelp,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'lokasi': lokasi,
      'notelp': notelp,
      'note': note,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      nama: map['nama'] as String,
      lokasi: map['lokasi'] as String,
      notelp: map['notelp'] as String,
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) => Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(nama: $nama, lokasi: $lokasi, notelp: $notelp, note: $note)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;
  
    return 
      other.nama == nama &&
      other.lokasi == lokasi &&
      other.notelp == notelp &&
      other.note == note;
  }

  @override
  int get hashCode {
    return nama.hashCode ^
      lokasi.hashCode ^
      notelp.hashCode ^
      note.hashCode;
  }
}
