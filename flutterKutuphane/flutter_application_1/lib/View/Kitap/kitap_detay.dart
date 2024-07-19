import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/kitap_controller.dart';
import 'package:flutter_application_1/Model/kitap.dart';
import 'package:flutter_application_1/View/Kategori/kategori_page.dart';
import 'package:flutter_application_1/View/Yazar/yazarlar_page.dart';
import 'package:get/get.dart';

class KitapDetay extends StatelessWidget {
  final int? kitapId;
  final kitapController = Get.put(KitapController());
  
  KitapDetay({super.key, required this.kitapId});
  final katid = 0.obs;
  final yazid = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitap Detay'),
      ),
      body: FutureBuilder<Kitap?>(
        future: kitapController.getKitap(kitapId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          } else {
            final kitap = snapshot.data;
            final TextEditingController adController =
                TextEditingController(text: kitap!.ad);
            final TextEditingController kategoriAdiController =
                TextEditingController(text: kitap.adi);
            final TextEditingController yazarAdiController =
                TextEditingController(text: kitap.adyazar);
            final TextEditingController yayinYiliController =
                TextEditingController(text: kitap.yayinYili);
            final TextEditingController sayfaSayisiController =
                TextEditingController(text: kitap.sayfaSayisi);
            final TextEditingController fiyatController =
                TextEditingController(text: kitap.fiyat);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: adController,
                    labelText: 'Kitap Adı',
                    onChanged: (value) {
                      kitap.ad = value;
                    },
                  ),
                     TextFormField(
                 controller: kategoriAdiController,
                 readOnly: true, 
                 onTap: () {
                 Get.to(() =>KategoriPage())?.then((selectedCategory) {
                 if (selectedCategory != null) {
                   kategoriAdiController.text = selectedCategory.adi;
                   kitap.kategoriId = selectedCategory.id; }
                    });
               },
               decoration: const InputDecoration(
               labelText: 'Kategori Adı',
               suffixIcon: Icon(Icons.arrow_drop_down), 
               ),
                  ),
               TextFormField(
                 controller: yazarAdiController,
                 readOnly: true, 
                 onTap: () {
                 Get.to(() =>  YazarPage())?.then((selectedYazar) {
                 if (selectedYazar != null) {
                   yazarAdiController.text = selectedYazar.ad;
                   kitap.yazarId = selectedYazar.id; }
                    });
               },
               decoration: const InputDecoration(
               labelText: 'Yazar Adı',
               suffixIcon: Icon(Icons.arrow_drop_down), 
               ),
                  ),       
                  _buildTextField(
                    controller: yayinYiliController,
                    labelText: 'Yayın Yılı',
                    onChanged: (value) {
                      kitap.yayinYili = value;
                    },
                  ),
                  _buildTextField(
                    controller: sayfaSayisiController,
                    labelText: 'Sayfa Sayısı',
                    onChanged: (value) {
                      kitap.sayfaSayisi = value;
                    },
                  ),
                  _buildTextField(
                    controller: fiyatController,
                    labelText: 'Fiyat',
                    onChanged: (value) {
                      kitap.fiyat = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (kitapId == null) {
                        Kitap yeniKitap = Kitap(
                          ad: adController.text,
                          kategoriId: kitap.kategoriId,
                          kategoriAdi: kategoriAdiController.text,
                          yazarId: kitap.yazarId,
                          adyazar: yazarAdiController.text,
                          yayinYili: yayinYiliController.text,
                          sayfaSayisi: sayfaSayisiController.text,
                          fiyat: fiyatController.text,
                        );
                        await kitapController.addKitap(yeniKitap);
                      } else {
                        await kitapController.editKitap(kitapId!, kitap);
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
  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(labelText: labelText),
        ),
        const SizedBox(height: 16.0),
      ],
    );
    
  }
  
}
