// ignore_for_file: empty_catches

import 'package:flutter_application_1/AP%C4%B0/kullanici_api.dart';
import 'package:flutter_application_1/Model/kullanici.dart';
import 'package:flutter_application_1/View/Kullanici/kullanicilar_page.dart';
import 'package:get/get.dart';

class KullaniciController extends GetxController {
  RxList<Kullanici> kullanicilar = <Kullanici>[].obs; 
  final pageSize = 15.obs;

  Future<void> getKullaniciListe(int currentPage,
      {bool clearList = false}) async {
    try {
      if (clearList) {
        kullanicilar.clear();
      }
      var pagedResult =
      await ApiKullanici.getKullaniciListe(currentPage, pageSize.value);
      kullanicilar.addAll(pagedResult.kullanici!);
    } catch (e) {
      // 
    }
  }
   Future<bool> deleteKullanici(int id) async {
    try {
      bool success = await ApiKullanici.deleteKullanici(id);
      if (success) {
        kullanicilar.removeWhere((kullanici) => kullanici.id == id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
   Future<Kullanici?> getKullanici(int? id) async {
    try {
      var kullanici = await ApiKullanici.getKullanici(id); 
      kullanici ??= Kullanici();
      return kullanici; 
    } catch (e) {
     
      return null;
    }
  }

    Future<void> addKullanici(Kullanici kullanici) async {
    try {
      var success = await ApiKullanici.addKullanici(kullanici);
      if (success) {
        
        Get.to(() =>  KullaniciPage());
      } else {
        throw Exception('Kullanıcı Eklenemedi');
      }
    } catch (e) {
    }
  }

    Future<void> editKullanici(int id, Kullanici kullanici) async {
    try {
      var success = await ApiKullanici.editKullanici(id, kullanici);
      if (success) {
        var index = kullanicilar.indexWhere((element) => element.id == id);
        if (index != -1) 
        { 
          kullanicilar[index].adSoyad = kullanici.adSoyad;
          kullanicilar[index].email= kullanici.email;
          
          kullanicilar.refresh();
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


