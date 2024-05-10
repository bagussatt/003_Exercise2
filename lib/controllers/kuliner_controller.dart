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
      kulinerList.add(kuliner); // Opsional: Tambahkan ke list lokal jika perlu
    }
    return result;
  }
}