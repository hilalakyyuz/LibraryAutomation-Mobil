import 'dart:convert';

List<Kullanici> kullaniciListeFromJson(String str) => List<Kullanici>.from(json.decode(str).map((x) => Kullanici.fromJson(x)));

String kullaniciListeToJson(List<Kullanici> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Kullanici kullaniciFromJson(String str) => Kullanici.fromJson(json.decode(str));

String kullaniciToJson(Kullanici data) => json.encode(data.toJson());
List<Paged> pagedListeFromJson(String str) =>
    List<Paged>.from(json.decode(str).map((x) => Paged.fromJson(x)));

String pagedListeToJson(List<Paged> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Paged pagedFromJson(String str) => Paged.fromJson(json.decode(str));

String pagedToJson(Paged data) => json.encode(data.toJson());



class Paged {
  int? totalCount;
  int? pageSize;
  int? currentPage;
  int? totalPages;
  List<Kullanici>? kullanici;

  Paged({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    this.kullanici,
  });

  factory Paged.fromJson(Map<String, dynamic> json) => Paged(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        kullanici: json["Kullanici"] == null
            ? []
            : List<Kullanici>.from(
                json["Kullanici"]!.map((x) => Kullanici.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "Kullanici": kullanici == null
            ? []
            : List<dynamic>.from(kullanici!.map((x) => x.toJson())),
      };
}

class Kullanici {
    int? id;
    String? adSoyad;
    String? email;
    String?kayitYapan;
    String? kayitTarihi;
    String? degisiklikYapan;
    String? degisiklikTarihi;
    String? resim;

    Kullanici({
        this.id,
        this.adSoyad,
        this.email,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
        this.resim,
    });

    factory Kullanici.fromJson(Map<String, dynamic> json) => Kullanici(
        id: json["ID"],
        adSoyad: json["AdSoyad"],
        email: json["Email"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        resim: json["Resim"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "AdSoyad": adSoyad,
        "Email": email,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "Resim": resim,
    };
}
