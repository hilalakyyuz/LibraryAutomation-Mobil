import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/kategori_controller.dart';
import 'package:flutter_application_1/Model/kategori.dart'; 
import 'package:get/get.dart';

class KategoriDetay extends StatelessWidget {
  final int? kategoriId;
  final kategoriController = Get.put(KategoriController());
  final TextEditingController _controller = TextEditingController();

  // ignore: use_super_parameters
  KategoriDetay({Key? key, required this.kategoriId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Detay'),
      ),
      body: FutureBuilder<Kategori?>(
        future: kategoriController.getKategori(kategoriId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); 
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          } else {
            final kategori = snapshot.data;
            _controller.text = kategori!.adi??'';
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _controller,
                    onChanged: (value) {
                      kategori.adi = value;
                    },
                    decoration: const InputDecoration(labelText: 'Kategori Adı'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (kategoriId == null) {
                      
                        Kategori yeniKategori = Kategori(adi: _controller.text);
                        await kategoriController.addKategori(yeniKategori);
                      } else {
                 
                        await kategoriController.editKategori(kategoriId!, kategori);
                      }
                    },
                    child: const Text('Kaydet'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
