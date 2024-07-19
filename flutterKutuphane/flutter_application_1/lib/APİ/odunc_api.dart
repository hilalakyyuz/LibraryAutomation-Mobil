import 'dart:convert';
import 'package:flutter_application_1/Model/odunc.dart';
import 'package:flutter_application_1/Service/service.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiOdunc {
  static String apiUrl ="http://192.168.1.251";
   static Future<Paged> getOduncListe(int pageNumber, int pageSize,String kullaniciAd ,String kitapAd) 
   async {
     Paged list = Paged();
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse(
                "$apiUrl/api/odunc/GetOduncler2?kullaniciAd=$kullaniciAd&kitapAd=$kitapAd&pageNumber=$pageNumber&pageSize=$pageSize"),
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
  static Future<Odunc?> getOdunc(int? id) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.get(
        Uri.parse('$apiUrl/api/odunc/GetOdunc/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        }
      );
      if (response.statusCode == 200) {
        return oduncFromJson(response.body);
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
static Future<bool> addOdunc(Odunc odunc) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.post(
        Uri.parse('$apiUrl/api/odunc/PostOdunc'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(odunc.toJson()),
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
static Future<bool> editOdunc(int id,Odunc odunc) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.put(
        Uri.parse('$apiUrl/api/odunc/PutOdunc/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode(odunc.toJson()),
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

  static Future<bool> deleteOdunc(int id) async {
  try {
    var token = await DBToken.getToken();
    if (token != null) {
      var response = await http.get(
      Uri.parse('$apiUrl/api/odunc/GetOduncSil?id=$id'),
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

