import 'package:flutter_application_1/AP%C4%B0/kategori_api.dart';
import 'package:flutter_application_1/AP%C4%B0/kitap_api.dart';
import 'package:flutter_application_1/AP%C4%B0/yazar_api.dart';
import 'package:flutter_application_1/Model/kategori.dart';
import 'package:flutter_application_1/Model/kitap.dart';
import 'package:flutter_application_1/Model/yazar.dart';
import 'package:get/get.dart';

import '../View/Kitap/kitaplar_page.dart';

class KitapController extends GetxController {
  RxList<Kitap> kitaplar = <Kitap>[].obs;
   List<String> selectedKategoriler = [];
  List<Kategori> kategoriList = [];
  List<Yazar> yazarList = [];
  final pageSize = 15.obs;
  var secilenKategoriler = <String>[].obs;
  var secilenYazarlar = <String>[].obs;
  final kategoriAdlari = <String>[].obs;
  final yazarAdlari = <String>[].obs;
 
  

   void initializeLists(List<Kategori> kategoriList, List<Yazar> yazarList) {
    this.kategoriList = kategoriList;
    this.yazarList= yazarList;
  }
  Future<void> getKitapListe(int currentPage, {bool clearList = false}) async {
    try {
      if (clearList) {
        kitaplar.clear();
      }
      var pagedResult = await ApiKitap.getKitapListe(
        currentPage,
        pageSize.value,
        kategoriAdlari.join(','), 
        yazarAdlari.join(','), 
      );
      var pagedKategoriList = await ApiKategori.getKategoriListe('', null, 1, 100); 
      var pagedYazarList = await ApiYazar.getYazarListe(1, 100); 

      var kategoriList = pagedKategoriList.kategori;
      var yazarList = pagedYazarList.yazar;

      initializeLists(kategoriList!, yazarList!);
      
      if (clearList) {
        kitaplar.assignAll(pagedResult.kitap!);
      } else {
        kitaplar.addAll(pagedResult.kitap!);
      }
    } catch (e) {
     // 
    }
  }
void filterByKategoriAdlari(List<String>  kategoriAdlari) {
    this. kategoriAdlari.assignAll( kategoriAdlari);
    getKitapListe(1, clearList: true);
  }

  void filterByYazarAdlari(List<String> yazarAdlari) {
    this.yazarAdlari.assignAll(yazarAdlari);
     getKitapListe(1, clearList: true);
  }
  Future<bool> deleteKitap(int id) async {
    try {
      bool success = await ApiKitap.deleteKitap(id);
      if (success) {
        kitaplar.removeWhere((kitap) => kitap.id == id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Kitap?> getKitap(int? id) async {
    try {
      var kitap = await ApiKitap.getKitap(id);
      kitap ??= Kitap();
      return kitap;
    } catch (e) {
      return null;
    }
  }

  Future<void> addKitap(Kitap kitap) async {
    try {
      var success = await ApiKitap.addKitap(kitap);
      if (success) {
        Get.to(() => const KitapPage());
      } else {
        throw Exception('Kitap Eklenemedi');
      }
    } catch (e) {
      // 
    }
  }

  Future<void> editKitap(int id, Kitap kitap) async {
    try {
      var success = await ApiKitap.editKitap(id, kitap);
      if (success) {
        var index = kitaplar.indexWhere((element) => element.id == id);
        if (index != -1) {
          kitaplar[index].ad = kitap.ad;
          kitaplar[index].adi = kitap.adi;
          kitaplar[index].adyazar = kitap.adyazar;
          kitaplar[index].yayinYili = kitap.yayinYili;
          kitaplar[index].sayfaSayisi = kitap.sayfaSayisi;
          kitaplar[index].fiyat = kitap.fiyat;
          kitaplar.refresh();
        }
        Get.back();
      } else {
        throw Exception('Kategori Güncellenemedi');
      }
    } catch (e) {
      // 
    }
  }
}