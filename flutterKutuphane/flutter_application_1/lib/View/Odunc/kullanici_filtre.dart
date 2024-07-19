import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/odunc_controller.dart';
import 'package:get/get.dart';

class KullaniciFiltre extends StatelessWidget {
  final OduncController oduncController = Get.find<OduncController>();

  KullaniciFiltre({super.key});

  void _applyFilters() {
    List<String> kullaniciAdlari = oduncController.secilenKullanicilar;
    oduncController.filterByKullaniciAdlari(kullaniciAdlari);
    oduncController.secilenKullanicilar.clear(); // Seçilen kullanıcıları temizle
    Get.back(); // Geri git
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtrele'),
      ),
      body: Column(children: [
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
                        'Kullanıcı Seç',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: oduncController.kullaniciList.length,
                        itemBuilder: (context, index) {
                          final kullanici =
                              oduncController.kullaniciList[index];
                          return Obx(() {
                            bool isSelected =
                                oduncController.secilenKullanicilar.contains(kullanici.adSoyad);
                            return CheckboxListTile(
                              title: Row(
                                children: [
                                  Text('${index + 1}. '),
                                  Text(kullanici.adSoyad.toString()),
                                ],
                              ),
                              value: isSelected,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  oduncController.secilenKullanicilar.add(kullanici.adSoyad!);
                                } else {
                                  oduncController.secilenKullanicilar.remove(kullanici.adSoyad);
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
      ]),
    );
  }
}
