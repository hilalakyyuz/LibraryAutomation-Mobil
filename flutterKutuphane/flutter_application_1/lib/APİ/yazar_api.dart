import 'dart:convert';

import 'package:flutter_application_1/Model/yazar.dart';
import 'package:flutter_application_1/Service/service.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiYazar {
  static String apiUrl = "http://192.168.1.251";

  static Future<Paged> getYazarListe(int pageNumber, int pageSize) async {
    Paged list = Paged();
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
            Uri.parse(
                "$apiUrl/api/yazarlar/GetYazarlar2?pageNumber=$pageNumber&pageSize=$pageSize"),
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

  static Future<Yazar?> getYazar(int? id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http
            .get(Uri.parse('$apiUrl/api/yazarlar/GetYazar/$id'), headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
        if (response.statusCode == 200) {
          return yazarFromJson(response.body);
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

  static Future<bool> addYazar(Yazar yazar) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.post(
          Uri.parse('$apiUrl/api/yazarlar/PostYazar'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(yazar.toJson()),
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

  static Future<bool> editYazar(int id, Yazar yazar) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.put(
          Uri.parse('$apiUrl/api/yazarlar/PutYazar/$id'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(yazar.toJson()),
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

  static Future<bool> deleteYazar(int id) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.get(
          Uri.parse('$apiUrl/api/yazarlar/GetYazarSil?id=$id'),
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
