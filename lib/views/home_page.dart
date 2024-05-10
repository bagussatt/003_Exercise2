import 'package:flutter/material.dart';
import 'package:kulinerjogja/controllers/kuliner_controller.dart';
import 'package:kulinerjogja/repository/kuliner_repository.dart';
import 'package:kulinerjogja/services/kuliner_service.dart';
import 'package:kulinerjogja/views/add_kuliner_screen.dart';
import 'package:kulinerjogja/views/edit_kulinerscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late KulinerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = KulinerController(KulinerRepository(KulinerService()));
    _controller.fetchKuliner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kuliner Yogyakarta"),
      ),
      body: FutureBuilder(
        future: _controller.fetchKuliner(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: _controller.kulinerList.length,
              itemBuilder: (context, index) {
                var kuliner = _controller.kulinerList[index];
                return Card(
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditKulinerScreen(
                                      ListData: {
                                        "id": kuliner.id,
                                        "nama": kuliner.nama,
                                        "lokasi": kuliner.lokasi,
                                        "notelp": kuliner.notelp,
                                        "note": kuliner.note
                                      },
                                    )),
                          );
                        },
                        child: ListTile(
                            title: Text("Nama Kuliner: ${kuliner.nama}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            subtitle: Text("Lokasi: ${kuliner.lokasi}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                // Tampilkan dialog konfirmasi
                                bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Konfirmasi Penghapusan'),
                                      content: Text(
                                          'Apakah Anda yakin ingin menghapus data ini?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Batal'),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                false); // Tutup dialog dan kembalikan false
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Hapus'),
                                          onPressed: () {
                                            Navigator.of(context).pop(
                                                true); // Tutup dialog dan kembalikan true
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                // Jika konfirmasi penghapusan diterima
                                if (confirmDelete) {
                                  bool success = await _controller
                                      .deleteKuliner(kuliner.id);
                                  if (success) {
                                    print(kuliner.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Data berhasil dihapus")));
                                    // Refresh data atau update UI di sini jika diperlukan
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Gagal menghapus data")));
                                  }
                                }
                              },
                            ))));
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddKulinerScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Tambah Kuliner',
      ),
    );
  }
}
