import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/kitap_controller.dart';

class KategoriFiltre extends StatelessWidget {
  final KitapController kitapController = Get.find<KitapController>();

  // ignore: use_super_parameters
  KategoriFiltre({Key? key}) : super(key: key);

  void _applyFilters() {
    List<String> kategoriAdlari = kitapController.secilenKategoriler;
    kitapController.filterByKategoriAdlari(kategoriAdlari);
    kitapController.secilenKategoriler.clear(); 
    Get.back(); 
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrele'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Kategori Seç',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: kitapController.kategoriList.length,
                    itemBuilder: (context, index) {
                      final kategori = kitapController.kategoriList[index];
                      return Obx(() {
                        bool isSelected = kitapController.secilenKategoriler.contains(kategori.adi);
                        return CheckboxListTile(
                          title: Row(
                            children: [
                              Text('${index + 1}. '),
                              Text(kategori.adi.toString()),
                            ],
                          ),
                          value: isSelected,
                          onChanged: (bool? value) {
                            if (value == true) {
                              kitapController.secilenKategoriler.add(kategori.adi!);
                            } else {
                              kitapController.secilenKategoriler.remove(kategori.adi!);
                            }
                          },
                          activeColor: Colors.blue,
                          checkColor: Colors.white,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
             child: ElevatedButton(
               onPressed: _applyFilters, 
               style: ElevatedButton.styleFrom(
               backgroundColor: Colors.white,
                  
              ),
              child: const Text(
                'Uygula',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
