import 'package:kulinerjogja/models/kuliner.dart';
import 'package:kulinerjogja/services/kuliner_service.dart';

class KulinerRepository {
  final KulinerService kulinerService;

  KulinerRepository(this.kulinerService);

  Future<List<Kuliner>> fetchKuliner() async {
    return kulinerService.fetchKuliner();
  }

  Future<bool> addKuliner(Kuliner kuliner) async {
    return kulinerService.addKuliner(kuliner);
  }
   Future<bool> editKuliner(Kuliner kuliner) async {
    return kulinerService.editKuliner(kuliner);
  }
   Future<bool> deleteKuliner(String id) async {
    return await kulinerService.deleteKuliner(id);
  }
}