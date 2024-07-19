import 'dart:convert';
import 'dart:typed_data';

Resim resimFromJson(String str) => Resim.fromJson(json.decode(str));

String resimToJson(Resim data) => json.encode(data.toJson());

List<Resim> resimListeFromJson(String str) =>
    List<Resim>.from(json.decode(str).map((x) => Resim.fromJson(x)));

String resimListeToJson(List<Resim> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Resim {
  int? id;
  int? kullaniciID;
  bool? varsayilanResim;
  String? resim;

  Resim({
    this.id,
    this.kullaniciID,
    this.varsayilanResim,
    this.resim,
  });

  factory Resim.fromJson(Map<String, dynamic> json) => Resim(
        id: json["ID"],
        kullaniciID: json["KullaniciID"],
        varsayilanResim: json["varsayilanResim"],
        resim: json["Resim"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "KullaniciID": kullaniciID,
        "varsayilanResim": varsayilanResim,
        "Resim": resim,
      };

  // Base64 formatındaki resmi Uint8List'e dönüştüren fonksiyon
  Uint8List getResimBytes() {
    if (resim != null) {
      return base64Decode(resim!);
    } else {
      return Uint8List(0);
    }
  }
}
