// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/kullanici_controller.dart';
import 'package:flutter_application_1/View/Kullanici/kullanici_detay.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class KullaniciPage extends StatelessWidget {
  final KullaniciController kullaniciController = Get.put(KullaniciController());
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _currentPage = 1;
      await kullaniciController.getKullaniciListe(_currentPage, clearList: true);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcılar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Kullanıcı Ara...',
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
                if (kullaniciController.kullanicilar.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: kullaniciController.kullanicilar.length + 1,
                    itemBuilder: (context, index) {
                      if (index == kullaniciController.kullanicilar.length) {
                        return _isLoading ? _buildProgressIndicator() : Container();
                      } else {
                        final kullanici = kullaniciController.kullanicilar[index];
                        Uint8List? imageBytes;
                        if (kullanici.resim != null && kullanici.resim!.isNotEmpty) {
                          imageBytes = base64Decode(kullanici.resim!);
                        }
                        return Card(
                          elevation: 15,
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    Get.to(() => KullaniciDetay(kullaniciId: kullanici.id));
                                  },
                                  backgroundColor:const Color.fromARGB(255, 64, 176, 8),
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
                                    final int id = kullanici.id!;
                                    kullaniciController.deleteKullanici(id);
                                  },
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  label: 'Sil',
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: imageBytes != null
                                  ? Image.memory(imageBytes)
                                  : const Icon(Icons.person_2),
                              title: Text('ID: ${kullanici.id}'),
                              onTap: () {
                                final selectedKullanici = kullaniciController.kullanicilar[index];
                                Get.back(result: selectedKullanici);
                              },
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ad Soyad: ${kullanici.adSoyad}'),
                                  Text('Email: ${kullanici.email}'),
                                ],
                              ),
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
        onPressed: () {
          Get.to(() => KullaniciDetay(kullaniciId: null));
        },
        tooltip: 'Yeni Kayıt Ekle',
        backgroundColor: const Color.fromARGB(255, 237, 240, 237),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 41, 23, 234)),
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _isLoading = true;
      _currentPage += 1;
      await kullaniciController.getKullaniciListe(_currentPage);
      _isLoading = false;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }


}
