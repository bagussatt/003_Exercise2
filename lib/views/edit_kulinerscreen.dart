import 'package:flutter/material.dart';
import 'package:kulinerjogja/controllers/kuliner_controller.dart';
import 'package:kulinerjogja/models/kuliner.dart';
import 'package:kulinerjogja/repository/kuliner_repository.dart';
import 'package:kulinerjogja/services/kuliner_service.dart';
import 'package:kulinerjogja/views/home_page.dart';
import 'package:kulinerjogja/views/map_page.dart';

class EditKulinerScreen extends StatefulWidget {
  final Map ListData;
  const EditKulinerScreen({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditKulinerScreen> createState() => _EditKulinerScreenState();
}

class _EditKulinerScreenState extends State<EditKulinerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _id = TextEditingController();
  final _namaController = TextEditingController();
  final _noTeleponController = TextEditingController();
  final _note = TextEditingController();
  String? _alamatController;
  late KulinerController _controller;

  @override
  void initState() {
    super.initState();
    var kulinerService = KulinerService();
    var kulinerRepository = KulinerRepository(kulinerService);
    _controller = KulinerController(kulinerRepository);
  }

  Future<bool> _editKuliner() async {
    if (_formKey.currentState!.validate()) {
      Kuliner newKuliner = Kuliner(
        id: _id.text,
        nama: _namaController.text,
        lokasi: _alamatController ?? '',
        notelp: _noTeleponController.text,
        note: _note.text,
      );
      return await _controller.editKuliner(newKuliner);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _id.text = widget.ListData['id'];
    _namaController.text = widget.ListData['nama'];
    _noTeleponController.text = widget.ListData['notelp'];
    _note.text = widget.ListData['note'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kuliner Jogja'),
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
                    final success = await _editKuliner();
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sukses Mengedit data")),
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gagal Mengedit data")),
                      );
                    }
                  }
                },
                child: const Text('Edit Kuliner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
