import 'package:kulinerjogja/models/kuliner.dart';
import 'package:kulinerjogja/repository/kuliner_repository.dart';

class KulinerController {
  final KulinerRepository kulinerRepository;
  List<Kuliner> kulinerList = [];

  KulinerController(this.kulinerRepository);

  Future<void> fetchKuliner() async {
    kulinerList = await kulinerRepository.fetchKuliner();
  }

  Future<bool> addKuliner(Kuliner kuliner) async {
    bool result = await kulinerRepository.addKuliner(kuliner);
    if (result) {
      kulinerList.add(kuliner); 
    }
    return result;
  }
  Future<bool> editKuliner(Kuliner kuliner) async {
    bool result = await kulinerRepository.editKuliner(kuliner);
    if (result) {
      kulinerList.add(kuliner); 
    }
    return result;
  }
   Future<bool> deleteKuliner(String id) async {
    return kulinerRepository.deleteKuliner(id);
  }
}