import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kulinerjogja/models/kuliner.dart';

class KulinerService {
  final String baseUrl = 'http://192.168.100.31/kulinerdb/read.php';

  Future<List<Kuliner>> fetchKuliner() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Kuliner.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load kuliner');
    }
  }
}