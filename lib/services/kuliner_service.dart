import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kulinerjogja/models/kuliner.dart';

class KulinerService {
  final String baseUrl = 'http://192.168.100.31/kulinerdb/';

  Future<List<Kuliner>> fetchKuliner() async {
    final response = await http.get(Uri.parse('${baseUrl}read.php'));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Kuliner.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load kuliner');
    }
  }

  Future<bool> addKuliner(Kuliner kuliner) async {
    var uri = Uri.parse('http://192.168.100.31/kulinerdb/create.php');
    var request = http.MultipartRequest('POST', uri)
      ..fields['nama'] = kuliner.nama
      ..fields['lokasi'] = kuliner.lokasi
      ..fields['notelp'] = kuliner.notelp;
    var response = await request.send();
    return response.statusCode == 200;
  }

  Future<bool> editKuliner(Kuliner kuliner) async {
    var uri = Uri.parse('http://192.168.100.31/kulinerdb/edit.php');
    var request = http.MultipartRequest('POST', uri)
      ..fields['id'] = kuliner.id
      ..fields['nama'] = kuliner.nama
      ..fields['lokasi'] = kuliner.lokasi
      ..fields['notelp'] = kuliner.notelp
      ..fields['note'] = kuliner.note;
    var response = await request.send();
    return response.statusCode == 200;
  }

  Future<bool> deleteKuliner(String id) async {
    var url = Uri.parse('$baseUrl/delete.php');
    var response = await http.post(url, body: {'id': id});
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['pesan'] == 'sukses') {
        print('Successfully deleted kuliner with id $id');
        return true;
      } else {
        print('Failed to delete kuliner: ${responseData['error']}');
        return false;
      }
    } else {
      print('Failed to delete kuliner: ${response.body}');
      return false;
    }
  }
}
