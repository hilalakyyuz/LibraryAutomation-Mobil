// ignore_for_file: empty_catches
import 'package:flutter_application_1/AP%C4%B0/kategori_api.dart';
import 'package:flutter_application_1/Model/kategori.dart';
import 'package:get/get.dart';

class KategoriController extends GetxController {
  final kategoriler = <Kategori>[].obs;
  final selectedCategory = Rx<Kategori?>(null);
  final pageSize = 15.obs;
  final adi = ''.obs;
  final id = Rx<int?>(null);
  final isLoading = false.obs;
  final currentPage = 1.obs;
  final filteredKategoriler = <Kategori>[].obs;

  @override
  void onInit() {
    super.onInit();
   
    filteredKategoriler.assignAll(kategoriler);
  }
  void getKategorilerFiltre({String? ad}) {
    adi.value = ad ?? '';
    if (adi.isEmpty) {
     
      filteredKategoriler.assignAll(kategoriler);
    } else {
     
      filteredKategoriler.assignAll(kategoriler.where((kategori) => kategori.adi!.contains(adi)));
    }
   
    kategoriler.assignAll(filteredKategoriler);
    getKategoriListe(1, clearList: true);
  }


  Future<void> getKategoriListe(int currentPage, {bool clearList = false}) async {
    try {
      if (clearList) {
        kategoriler.clear();
        this.currentPage.value = 1;
      } else {
        this.currentPage.value = currentPage;
      }
      var pagedResult = await ApiKategori.getKategoriListe(adi.value, id.value, currentPage, pageSize.value);
      kategoriler.addAll(pagedResult.kategori!);
    } catch (e) {
      // 
    }
  }

  Future<bool> deleteKategori(int id) async {
    try {
      bool success = await ApiKategori.deleteKategori(id);
      if (success) {
        kategoriler.removeWhere((kategori) => kategori.id == id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<Kategori?> getKategori(int? id) async {
    try {
      var kategori = await ApiKategori.getKategori(id);
      kategori ??= Kategori();
      return kategori;
    } catch (e) {
      return null;
    }
  }

  Future<void> addKategori(Kategori kategori) async {
  try {
    var success = await ApiKategori.addKategori(kategori);
    if (success) {
      
      Get.back(result: true); 
    } else {
      throw Exception('Kategori Eklenemedi');
    }
  } catch (e) {
    // 
  }
}

  Future<void> editKategori(int id, Kategori kategori) async {
    try {
      var success = await ApiKategori.editKategori(id, kategori);
      if (success) {
        var index = kategoriler.indexWhere((element) => element.id == id);
        if (index != -1) {
          kategoriler[index].adi = kategori.adi;
          kategoriler.refresh();
        }
        Get.back();
      } else {
        throw Exception('Kategori Güncellenemedi');
      }
    } catch (e) {
      // 
    }
  }

  void selectCategory(Kategori? kategori) {
    selectedCategory.value = kategori;
  }

  Kategori? getSelectedCategory() {
    return selectedCategory.value;
  }
}