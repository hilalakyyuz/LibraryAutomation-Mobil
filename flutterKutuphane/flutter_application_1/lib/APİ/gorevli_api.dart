import 'dart:convert';
import 'package:flutter_application_1/Model/gorevli.dart';
import 'package:flutter_application_1/Service/service.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiGorevli {
  static String apiUrl = "http://192.168.1.251";

  static Future<String> girisYap(Gorevli gorevli) async {
    try {
      var token = await DBToken.getToken();
      if (token != null) {
        var response = await http.post(
          Uri.parse("$apiUrl/api/login"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(gorevli.toJson()),
        );

        if (response.statusCode == 200) {
          return "Giriş başarılı.";
        } else if (response.statusCode == 400) {
      
          return "Kullanıcı adı veya şifre boş olamaz.";
        } else if (response.statusCode == 401) {
         
          return "Yanlış şifre.";
        } else if (response.statusCode == 404) {
          
          return "Kullanıcı adı veya şifre  yanlış.";
        } else {
          
          return "Beklenmeyen bir hata oluştu.";
        }
      } else {
        return "Token alınamadı.";
      }
    } catch (e) {
     
      return "Bir hata oluştu.";
    }
  }
}
