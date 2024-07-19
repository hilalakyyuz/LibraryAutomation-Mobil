import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/AP%C4%B0/resim_api.dart';
import 'package:flutter_application_1/Model/resim.dart';
import 'package:get/get.dart';

class ResimController extends GetxController {
  RxList<Resim> resimler = <Resim>[].obs;

  Future<void> getResimListe() async {
    try {
      List<Resim>? resimListe = await ApiResim.getResimListe();
      if (resimListe != null) {
        resimListe.sort((a, b) => b.id!.compareTo(a.id!));
        resimler.assignAll(resimListe);
      }
    } catch (e) {
      //
    }
  }

  Future<Resim?> getVarsayilanResim(int? kullaniciID) async {
    try {
      return await ApiResim.getVarsayilanResim(kullaniciID);
    } catch (e) {
      return null;
    }
  }
  Future<void> getResimlerByKullaniciID(int kullaniciID) async {
    try {
      List<Resim>? resimListe =
          await ApiResim.getResimlerByKullaniciID(kullaniciID);
      if (resimListe != null) {
        resimler.assignAll(resimListe);
        resimler.refresh();
      }
    } catch (e) {
      //
    }
  }
  Future<bool> addResim(File image, int kullaniciId) async {
    try {
      String base64Image = base64Encode(await image.readAsBytes());
      Resim resim = Resim(resim: base64Image, kullaniciID: kullaniciId);
      bool success = await ApiResim.addResim([resim]);
      return success;
    } catch (e) {
      return false;
    }
  }
 Future<bool> editVarsayilanResim(Resim resim) async {
  try {
    resim.varsayilanResim = true; 
    bool success = await ApiResim.editResim(resim);

    if (success) {
      for (var otherResim in resimler) {
        if (otherResim.kullaniciID == resim.kullaniciID && otherResim != resim) {
          otherResim.varsayilanResim = false;
          ApiResim.editResim(otherResim); 
        }
      }

      return true; 
    }
    return false; 
  } catch (e) {
    //
    return false;
  }
}
  Future<bool> deleteResim(int id) async {
    try {
      bool success = await ApiResim.deleteResim(id);
      if (success) {
        resimler.removeWhere((resim) => resim.id == id);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
