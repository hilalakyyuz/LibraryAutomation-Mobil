import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/odunc_controller.dart';
import 'package:get/get.dart';

class KitapFiltre extends StatelessWidget {
  final OduncController oduncController = Get.find<OduncController>();

  // ignore: use_super_parameters
  KitapFiltre({Key? key}) : super(key: key);

  void _applyFilters() {
    List<String> kitapAdlari = oduncController.secilenKitaplar;
    oduncController.filterByKitapAdlari(kitapAdlari);
    oduncController.secilenKitaplar.clear(); 
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
                    'Kitap Seç',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: oduncController.kitapList.length,
                    itemBuilder: (context, index) {
                      final kitap = oduncController.kitapList[index];
                      return Obx(() {
                        bool isSelected =
                            oduncController.secilenKitaplar.contains(kitap.ad);
                        return CheckboxListTile(
                          title: Row(
                            children: [
                              Text('${index + 1}. '),
                              Text(kitap.ad.toString()),
                            ],
                          ),
                          value: isSelected,
                          onChanged: (bool? value) {
                            if (value == true) {
                              oduncController.secilenKitaplar.add(kitap.ad!);
                            } else {
                              oduncController.secilenKitaplar.remove(kitap.ad);
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
