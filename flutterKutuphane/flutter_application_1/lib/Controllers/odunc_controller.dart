// ignore_for_file: empty_catches
import 'package:flutter_application_1/AP%C4%B0/kitap_api.dart';
import 'package:flutter_application_1/AP%C4%B0/kullanici_api.dart';
import 'package:flutter_application_1/AP%C4%B0/odunc_api.dart';
import 'package:flutter_application_1/Model/kitap.dart';
import 'package:flutter_application_1/Model/kullanici.dart';
import 'package:flutter_application_1/Model/odunc.dart';
import 'package:flutter_application_1/View/Odunc/odunc_page.dart';
import 'package:get/get.dart';

class OduncController extends GetxController {
  RxList<Odunc> oduncler = <Odunc>[].obs;
  List<Kullanici> kullaniciList = [];
  List<Kitap> kitapList = [];
  final pageSize = 15.obs;
  var secilenKitaplar = <String>[].obs;
  var secilenKullanicilar = <String>[].obs;
  final kitapAdlari = <String>[].obs;
  final kullaniciAdlari = <String>[].obs;

  void initializeLists(List<Kullanici> kullaniciList, List<Kitap> kitapList) {
    this.kullaniciList = kullaniciList;
    this.kitapList = kitapList;
  }
  
  Future<void> getOduncListe(int currentPage, {bool clearList = false}) async {
    try {
      if (clearList) {
        oduncler.clear();
      }
      var pagedResult = await ApiOdunc.getOduncListe(
        currentPage,
        pageSize.value,
        kullaniciAdlari.join(','), 
        kitapAdlari.join(','), 
      );
      var pagedKullaniciList = await ApiKullanici.getKullaniciListe(1, 100); 
      var pagedKitapList= await ApiKitap.getKitapListe(1, 100,'',''); 

      var kullaniciList = pagedKullaniciList.kullanici;
      var kitapList = pagedKitapList.kitap;

      initializeLists(kullaniciList!, kitapList!);

      if (clearList) {
        oduncler.assignAll(pagedResult.odunc!);
      } else {
        oduncler.addAll(pagedResult.odunc!);
      }
    } catch (e) {
      // 
    }
  }
  void filterByKullaniciAdlari(List<String> kullaniciAdlari) {
    this.kullaniciAdlari.assignAll(kullaniciAdlari);
    getOduncListe(1, clearList: true);
  }

  void filterByKitapAdlari(List<String> kitapAdlari) {
    this.kitapAdlari.assignAll(kitapAdlari);
    getOduncListe(1, clearList: true);
  }
  
  Future<bool> deleteOdunc(int id) async {
    try {
      bool success = await ApiOdunc.deleteOdunc(id);
      if (success) {
        oduncler.removeWhere((odunc) => odunc.id == id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Odunc?> getOdunc(int? id) async {
    try {
      var odunc = await ApiOdunc.getOdunc(id);
      odunc ??= Odunc();
     var pagedKullaniciList = await ApiKullanici.getKullaniciListe(1, 100); 
     var pagedKitapList = await ApiKitap.getKitapListe(1, 100, '',  ''); 

      var kullaniciList = pagedKullaniciList.kullanici;
      var kitapList = pagedKitapList.kitap;

      Get.find<OduncController>().initializeLists(kullaniciList!, kitapList!);
      return odunc;
    } catch (e) {
      return null;
    }
  }

  Future<void> addOdunc(Odunc odunc) async {
    try {
      var success = await ApiOdunc.addOdunc(odunc);
      if (success) {
        Get.to(() => const OduncPage());
      } else {
        throw Exception('Ödünç Eklenemedi');
      }
    } catch (e) {}
  }

  Future<void> editOdunc(int id, Odunc odunc) async {
    try {
      var success = await ApiOdunc.editOdunc(id, odunc);
      if (success) {
        var index = oduncler.indexWhere((element) => element.id == id);
        if (index != -1) {
          oduncler[index].kullaniciAdi = odunc.kullaniciAdi;
          oduncler[index].kitapAdi = odunc.kitapAdi;
          oduncler[index].alisTarihi = odunc.alisTarihi;
          oduncler[index].teslimTarihi = odunc.teslimTarihi;
          oduncler[index].teslimDurumu = odunc.teslimDurumu;

          oduncler.refresh();
        }
        Get.back();
      } else {
        throw Exception('Yazar Güncellenemedi');
      }
    } catch (e) {
      //
    }
  }
}
