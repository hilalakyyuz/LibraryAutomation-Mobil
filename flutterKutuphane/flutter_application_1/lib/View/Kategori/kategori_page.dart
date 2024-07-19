// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/Kategori/kategori_detay.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/Controllers/kategori_controller.dart';

class KategoriPage extends StatelessWidget {
  KategoriPage({Key? key}) : super(key: key);

  final KategoriController kategoriController = Get.put(KategoriController());
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !kategoriController.isLoading.value) {
        kategoriController.isLoading.value = true;
        await kategoriController.getKategoriListe(kategoriController.currentPage.value + 1);
        kategoriController.isLoading.value = false;
      }
    });

    if (kategoriController.kategoriler.isEmpty && !kategoriController.isLoading.value) {
      kategoriController.isLoading.value = true;
      kategoriController.getKategoriListe(1, clearList: true).then((_) {
        kategoriController.isLoading.value = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Kategori Ara...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) async {
                kategoriController.isLoading.value = true;
                kategoriController.getKategorilerFiltre(ad: value.isEmpty ? null : value);
                kategoriController.isLoading.value = false;
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (kategoriController.kategoriler.isEmpty && kategoriController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (kategoriController.kategoriler.isEmpty) {
                  return const Center(
                    child: Text('Kategori Bulunamadı'),
                  );
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: kategoriController.kategoriler.length + (kategoriController.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == kategoriController.kategoriler.length) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final kategori = kategoriController.kategoriler[index];
                        return Card(
                          elevation: 15,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Get.to(() => KategoriDetay(kategoriId: kategori.id));
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
                                    final int id = kategori.id!;
                                    kategoriController.deleteKategori(id);
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Sil',
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text('ID: ${kategori.id}'),
                              subtitle: Text('Ad: ${kategori.adi}'),
                              onTap: () {
                                final selectedCategory = kategoriController.kategoriler[index];
                                Get.back(result: selectedCategory);
                              },
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
        final result = await Get.to(() => KategoriDetay(kategoriId: null));
        if (result != null && result as bool) {
       kategoriController.getKategoriListe(1, clearList: true);
      }
        },
        tooltip: 'Yeni Kayıt Ekle',
        backgroundColor: const Color.fromARGB(255, 237, 240, 237),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 41, 23, 234)),
      ),
    );
  }
}