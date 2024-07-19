import 'dart:convert';

List<Yazar> yazarListeFromJson(String str) => List<Yazar>.from(json.decode(str).map((x) => Yazar.fromJson(x)));

String yazarListeToJson(List<Yazar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Yazar yazarFromJson(String str) => Yazar.fromJson(json.decode(str));

String yazarToJson(Yazar data) => json.encode(data.toJson());
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
  List<Yazar>? yazar;

  Paged({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    this.yazar,
  });

  factory Paged.fromJson(Map<String, dynamic> json) => Paged(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        yazar: json["Yazar"] == null
            ? []
            : List<Yazar>.from(
                json["Yazar"]!.map((x) => Yazar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "Yazar": yazar== null
            ? []
            : List<dynamic>.from(yazar!.map((x) => x.toJson())),
      };
}
class Yazar {
    int? id;
    String? ad;
    String? soyad;
    DateTime? dogumTarihi;
    String? ulke;
    String? kayitYapan;
    String? kayitTarihi;
    String? degisiklikYapan;
    String? degisiklikTarihi;

    Yazar({
        this.id,
        this.ad,
        this.soyad,
        this.dogumTarihi,
        this.ulke,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
    });

    factory Yazar.fromJson(Map<String, dynamic> json) => Yazar(
        id: json["ID"],
        ad: json["Ad"],
        soyad: json["Soyad"],
        dogumTarihi: json["DogumTarihi"] == null ? null : DateTime.parse(json["DogumTarihi"]),
        ulke: json["Ulke"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Ad": ad,
        "Soyad": soyad,
        "DogumTarihi": dogumTarihi?.toIso8601String(),
        "Ulke": ulke,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
    };
}
