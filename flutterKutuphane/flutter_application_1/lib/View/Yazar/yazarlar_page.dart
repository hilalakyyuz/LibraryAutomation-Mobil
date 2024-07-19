// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/Yazar/yazar_detay.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_1/Controllers/yazar_controller.dart';

class YazarPage extends StatelessWidget {
  final YazarController yazarController = Get.put(YazarController());
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yazarlar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Yazar Ara...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Filtreleme 
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (yazarController.yazarlar.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: yazarController.yazarlar.length,
                    itemBuilder: (context, index) {
                      final yazar = yazarController.yazarlar[index];
                      return Card(
                        elevation: 15,
                        margin:const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Slidable(
                          startActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  Get.to(() => YazarDetay(yazarId: yazar.id));
                                },
                                backgroundColor: const Color.fromARGB(255, 64, 176, 8),
                                icon: Icons.edit,
                                label: 'Düzenle',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  final int id = yazar.id!;
                                  yazarController.deleteYazar(id);
                                },
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                label: 'Sil',
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text('ID: ${yazar.id}'),
                            onTap: () {
                              final selectedYazar = yazarController.yazarlar[index];
                              Get.back(result: selectedYazar);
                            },
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Ad: ${yazar.ad}'),
                                Text('Soyad: ${yazar.soyad}'),
                                Text(('Doğum Tarihi: ${yazar.dogumTarihi != null ? DateFormat('dd/MM/yyyy').format(yazar.dogumTarihi!) : ''}')),
                                Text('Ülke: ${yazar.ulke}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => YazarDetay(yazarId: null));
        },
        tooltip: 'Yeni Yazar Ekle',
        backgroundColor: const Color.fromARGB(255, 237, 240, 237),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 41, 23, 234)),
      ),
    );
  }
}
