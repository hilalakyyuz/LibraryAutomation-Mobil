import 'dart:convert';
import 'package:flutter_application_1/Model/kullanici.dart';
import 'package:flutter_application_1/Service/service.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiKullanici {
  static String apiUrl ="http://192.168.1.251";

 static Future<Paged> getKullaniciListe(int pageNumber, int pageSize) async {
    Paged list = Paged();
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse(
                "$apiUrl/api/kullanicilar/GetKullanicilar3?pageNumber=$pageNumber&pageSize=$pageSize"),
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

  static Future<Kullanici?> getKullanici(int? id) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.get(
        Uri.parse('$apiUrl/api/kullanicilar/GetKullanici/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }
      );
      if (response.statusCode == 200) {
        return kullaniciFromJson(response.body);
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
   static Future<bool> addKullanici(Kullanici kullanici) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.post(
        Uri.parse('$apiUrl/api/kullanicilar/PostKullanici'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(kullanici.toJson()),
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
static Future<bool> editKullanici(int id, Kullanici kullanici) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.put(
        Uri.parse('$apiUrl/api/kullanicilar/PutKullanici/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(kullanici.toJson()),
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
  static Future<bool> deleteKullanici(int id) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.get(
      Uri.parse('$apiUrl/api/kullanicilar/GetKullaniciSil?id=$id'),
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

