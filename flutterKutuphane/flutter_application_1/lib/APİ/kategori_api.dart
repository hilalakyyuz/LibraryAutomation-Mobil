// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:flutter_application_1/Model/kategori.dart';
import 'package:flutter_application_1/Service/service.dart';
import 'package:http/http.dart' as http;

class ApiKategori {
  static String apiUrl = "http://192.168.1.251";

   static Future<Paged> getKategoriListe( String adi , int? id , int pageNumber, int pageSize) async {
    Paged list = Paged();
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse(
                "$apiUrl/api/kategoriler/GetKategoriler2?adi=$adi&id=$id&pageNumber=$pageNumber&pageSize=$pageSize"),
             headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
              'Accept': 'application/json'
            });
        if (response.statusCode == 200) {
          var list = pagedFromJson(((response.body)));
          return list;
        } else {
          return list;
        }
      } else {
        return list;
      }
    } catch (e) {
      return list;
    }
  }
  static Future<Kategori?> getKategori(int? id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse('$apiUrl/api/kategoriler/GetKategori/$id'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
              'Accept': 'application/json'
            });
        if (response.statusCode == 200) {
          return kategoriFromJson(response.body);
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

  static Future<bool> addKategori(Kategori kategori) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.post(
          Uri.parse('$apiUrl/api/kategoriler/PostKategori'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(kategori.toJson()),
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

  static Future<bool> editKategori(int id, Kategori kategori) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.put(
          Uri.parse('$apiUrl/api/kategoriler/PutKategori/$id'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(kategori.toJson()),
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

  static Future<bool> deleteKategori(int id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
          Uri.parse('$apiUrl/api/kategoriler/GetKategoriSil?id=$id'),
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

  static Future<List<Kategori>?> getKategorilerFiltre(
      {String? ad, int? id}) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        String url = "$apiUrl/api/kategoriler/GetKategorilerFiltre";
        if (ad != null || id != null) {
          List<String> queryParams = [];
          if (ad != null) queryParams.add("ad=$ad");
          if (id != null) queryParams.add("id=$id");
          url += "?${queryParams.join('&')}";
        }

        var response = await http.get(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });

        if (response.statusCode == 200) {
          List<dynamic> jsonList = jsonDecode(response.body);
          List<Kategori> kategoriListe =
              jsonList.map((e) => Kategori.fromJson(e)).toList();
          return kategoriListe;
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
}
