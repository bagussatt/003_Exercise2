import 'package:flutter/material.dart';
import 'package:kulinerjogja/controllers/kuliner_controller.dart';
import 'package:kulinerjogja/models/kuliner.dart';
import 'package:kulinerjogja/repository/kuliner_repository.dart';
import 'package:kulinerjogja/services/kuliner_service.dart';
import 'package:kulinerjogja/views/home_page.dart';
import 'package:kulinerjogja/views/map_page.dart';

class AddKulinerScreen extends StatefulWidget {
  const AddKulinerScreen({Key? key}) : super(key: key);

  @override
  State<AddKulinerScreen> createState() => _AddKulinerScreenState();
}

class _AddKulinerScreenState extends State<AddKulinerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _noTeleponController = TextEditingController();
  String? _alamatController;
  late KulinerController _controller;

  @override
  void initState() {
    super.initState();
    var kulinerService = KulinerService();
    var kulinerRepository = KulinerRepository(kulinerService);
    _controller = KulinerController(kulinerRepository);
  }

  Future<bool> _saveKuliner() async {
    if (_formKey.currentState!.validate()) {
      Kuliner newKuliner = Kuliner(
        id: "",
        nama: _namaController.text,
        lokasi: _alamatController ?? '',
        notelp: _noTeleponController.text,
        note: "",
      );
      return await _controller.addKuliner(newKuliner);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kuliner Jogja'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Kuliner',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama kuliner tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat"),
                    _alamatController == null
                        ? const SizedBox(
                            width: double.infinity,
                            child: Text('Alamat kosong'),
                          )
                        : Text('$_alamatController'),
                    TextButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MapPage(onLocationSelected: (selectedAddress) {
                              setState(() {
                                _alamatController = selectedAddress;
                              });
                            }),
                          ),
                        );
                      },
                      child: Text(_alamatController == null
                          ? 'Pilih Alamat'
                          : 'Ubah Alamat'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _noTeleponController,
                  decoration: const InputDecoration(
                    labelText: 'No Telepon',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final success = await _saveKuliner();
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sukses menyimpan data")),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gagal menyimpan data")),
                      );
                    }
                  }
                },
                child: const Text('Simpan Kuliner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
