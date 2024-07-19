// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter_application_1/Model/kitap.dart';
import 'package:flutter_application_1/Service/service.dart';
import 'package:http/http.dart' as http;

class ApiKitap {
  static String apiUrl = "http://192.168.1.251";

  static Future<Paged> getKitapListe(int pageNumber, int pageSize,String kategoriAd ,String yazarAd) 
  async {
     Paged list = Paged();
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse(
                "$apiUrl/api/kitaplar/GetKitaplar2?kategoriAd=$kategoriAd&yazarAd=$yazarAd&pageNumber=$pageNumber&pageSize=$pageSize"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-type': 'application/json',
              'Accept': 'application/json'
            } );
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

  static Future<Kitap?> getKitap(int? id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http
            .get(Uri.parse('$apiUrl/api/kitaplar/GetKitap/$id'), headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
        if (response.statusCode == 200) {
          return kitapFromJson(response.body);
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

  static Future<bool> addKitap(Kitap kitap) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.post(
          Uri.parse('$apiUrl/api/kitaplar/PostKitap'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(kitap.toJson()),
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

  static Future<bool> editKitap(int id, Kitap kitap) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.put(
          Uri.parse('$apiUrl/api/kitaplar/PutKitap/$id'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(kitap.toJson()),
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

  static Future<bool> deleteKitap(int id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
          Uri.parse('$apiUrl/api/kitaplar/GetKitapSil?id=$id'),
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
