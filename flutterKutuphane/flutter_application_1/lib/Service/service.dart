import 'dart:async';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class EntityToken {
  // ignore: non_constant_identifier_names
  String access_token;

  // ignore: non_constant_identifier_names
  EntityToken({required this.access_token});

  factory EntityToken.fromJson(Map<String, dynamic> json) {
    return EntityToken(access_token: json['access_token']);
  }
}
class DBToken {
  static String apiUsername = "1";
  static String apiPassword = "1";
  static EntityToken? apiToken;
  static DateTime apiTokenDate = DateTime.now();
  static String apiUrl = "http://192.168.1.251";

  static Future<String?> getToken() async {
    try {
      var client = http.Client();
      // ignore: unnecessary_brace_in_string_interps
      var response = await client.post(Uri.parse("${apiUrl}/token"),
          headers: <String, String>{
            'Content-Type': 'application/x-www-form-urlencoded',
          },
          body: <String, String>{
            'grant_type': 'password',
            'username': apiUsername,
            'password': apiPassword
          });
      client.close(); 
      if (response.statusCode == 200) {
        var result = EntityToken.fromJson(jsonDecode(response.body));
        apiToken = result;
        return apiToken!.access_token;
      } else {
        throw Exception('Failed to load token');
      }
    } catch (e) {
      return null;
    }
  }
}
