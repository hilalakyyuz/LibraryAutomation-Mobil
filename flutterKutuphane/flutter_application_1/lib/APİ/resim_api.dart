import 'dart:convert';
import 'package:flutter_application_1/Model/resim.dart';
import 'package:flutter_application_1/Service/service.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiResim {
  static String apiUrl = "http://192.168.1.251";
  static Future<List<Resim>?> getResimListe() async {
    List<Resim> resimListe = [];
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response =
            await http.get(Uri.parse("$apiUrl/api/resimler/liste"), headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
        if (response.statusCode == 200) {
          resimListe = resimListeFromJson(response.body);
          return resimListe;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Resim>?> getResimlerByKullaniciID(int kullaniciID) async {
    List<Resim> resimListe = [];
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse(
                "$apiUrl/api/resimler/kullanici?kullaniciID=$kullaniciID"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
              'Accept': 'application/json'
            });

        if (response.statusCode == 200) {
          resimListe = resimListeFromJson(response.body);
          return resimListe;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<Resim?> getVarsayilanResim(int? kullaniciID) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse('$apiUrl/api/resimler/varsayilan/$kullaniciID'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
              'Accept': 'application/json'
            });
        if (response.statusCode == 200) {
          return resimFromJson(response.body);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addResim(List<Resim> resim) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.post(
          Uri.parse('$apiUrl/api/resimler/ekle'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(resim.toList()),
        );
        if (response.statusCode == 201) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
   static Future<bool> editResim(Resim resim) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.put(
          Uri.parse('$apiUrl/api/resimler/duzenle/${resim.id}'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(resim.toJson()),
        );
        if (response.statusCode == 204) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteResim(int id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var apiUrl = "http://192.168.1.251"; 
        var response = await http.delete(
          Uri.parse(
              '$apiUrl/api/resimler/sil/$id'), 
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
        );
        if (response.statusCode == 200) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
