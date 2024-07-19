import 'package:flutter_application_1/AP%C4%B0/yazar_api.dart';
import 'package:flutter_application_1/Model/yazar.dart';
import 'package:flutter_application_1/View/Yazar/yazarlar_page.dart';
import 'package:get/get.dart';

class YazarController extends GetxController {
  RxList<Yazar> yazarlar = <Yazar>[].obs; 
  final selectedYazar = Rx<Yazar?>(null);
  final pageSize = 15.obs;
  final yazarAdlar = <String>[].obs; 

  @override
  void onInit() {
    super.onInit();
    _initializeLists();
  }

  Future<void> _initializeLists() async {
    try {
      var pagedResult = await ApiYazar.getYazarListe(1, pageSize.value);
      yazarlar.addAll(pagedResult.yazar!);

      // Yazar adlarını alarak listeye ekle.
      yazarAdlar.addAll(yazarlar.map((yazar) => yazar.ad).toSet() as Iterable<String>);
    } catch (e) {
      // 
    }
  }

  Future<void> getYazarListe(int currentPage,
      {bool clearList = false}) async {
    try {
      if (clearList) {
        yazarlar.clear();
      }
      var pagedResult =
      await ApiYazar.getYazarListe(currentPage, pageSize.value);
      yazarlar.addAll(pagedResult.yazar!);
    } catch (e) {
      // 
    }
  }
   Future<bool> deleteYazar(int id) async {
    try {
      bool success = await ApiYazar.deleteYazar(id);
      if (success) {
        yazarlar.removeWhere((yazar) => yazar.id == id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
     
      return false;
    }
  }
  Future<Yazar?> getYazar(int? id) async {
    try {
      var yazar = await ApiYazar.getYazar(id); 
      yazar ??= Yazar();
      return yazar; 
    } catch (e) {
    
      return null;
    }
  }
    Future<void> addYazar( Yazar yazar) async {
    try {
      var success = await ApiYazar.addYazar(yazar);
      if (success) {
        
         Get.to(() =>  YazarPage());
      } else {
        throw Exception('Yazar Eklenemedi');
      }
    } catch (e) {
     // 
    }
  }

    Future<void> editYazar(int id, Yazar yazar) async {
    try {
      var success = await ApiYazar.editYazar(id, yazar);
      if (success) {
        var index = yazarlar.indexWhere((element) => element.id == id);
        if (index != -1) 
        { 
          yazarlar[index].ad = yazar.ad;
          yazarlar[index].soyad = yazar.soyad;
          yazarlar[index].dogumTarihi = yazar.dogumTarihi;
          yazarlar[index].ulke = yazar.ulke;

          yazarlar.refresh();
        }
        Get.back();
      } else {
        throw Exception('Yazar Güncellenemedi');
      }
    } catch (e) {
     //
    }
  }
   void selectYazar(Yazar? yazar) {
    selectedYazar.value = yazar;
  }
    Yazar? getSelectedYazar() {
    return selectedYazar.value;
  }
}

