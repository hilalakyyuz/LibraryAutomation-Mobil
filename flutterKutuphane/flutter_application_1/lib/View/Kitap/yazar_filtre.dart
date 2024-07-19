import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/kitap_controller.dart';

class YazarFiltre extends StatelessWidget {
  final KitapController kitapController = Get.find<KitapController>();

  // ignore: use_super_parameters
  YazarFiltre({Key? key}) : super(key: key);

  void _applyFilters() {
    List<String> yazarAdlari = kitapController.secilenYazarlar;
    kitapController.filterByYazarAdlari(yazarAdlari);
    kitapController.secilenYazarlar.clear(); 
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
          const Divider(),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Yazar Seç',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: kitapController.yazarList.length,
                    itemBuilder: (context, index) {
                      final yazar = kitapController.yazarList[index];
                      return Obx(() {
                        bool isSelected = kitapController.secilenYazarlar.contains(yazar.ad);
                        return CheckboxListTile(
                          title: Row(
                            children: [
                              Text('${index + 1}. '),
                              Text(yazar.ad.toString()),
                            ],
                          ),
                          value: isSelected,
                          onChanged: (bool? value) {
                            if (value == true) {
                              kitapController.secilenYazarlar.add(yazar.ad!);
                            } else {
                              kitapController.secilenYazarlar.remove(yazar.ad);
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
          )
        ]
      ),
    );
  }
}
