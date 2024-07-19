import 'dart:convert';
List<Paged> pagedListeFromJson(String str) =>
    List<Paged>.from(json.decode(str).map((x) => Paged.fromJson(x)));

String pagedListeToJson(List<Paged> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Paged pagedFromJson(String str) => Paged.fromJson(json.decode(str));

String pagedToJson(Paged data) => json.encode(data.toJson());

Kitap kitapFromJson(String str) => Kitap.fromJson(json.decode(str));

String kitapToJson(Kitap data) => json.encode(data.toJson());

List<Kitap> kitapLFromJson(String str) =>
    List<Kitap>.from(json.decode(str).map((x) => Kitap.fromJson(x)));

String kitapLToJson(List<Kitap> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Paged {
  int? totalCount;
  int? pageSize;
  int? currentPage;
  int? totalPages;
  List<Kitap>? kitap;

  Paged({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    this.kitap,
  });

  factory Paged.fromJson(Map<String, dynamic> json) => Paged(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        kitap: json["Kitap"] == null
            ? []
            : List<Kitap>.from(
                json["Kitap"]!.map((x) =>Kitap.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "Kategori": kitap == null
            ? []
            : List<dynamic>.from(kitap!.map((x) => x.toJson())),
      };
}

class Kitap {
    int? id;
    String? ad;
    int? kategoriId;
    String? kategoriAdi;
    int? yazarId;
    String? yayinYili;
    String? sayfaSayisi;
    String? fiyat;
    String? kayitYapan;
    String? kayitTarihi;
    String? degisiklikYapan;
    String?degisiklikTarihi;
    String? adyazar;
    String? adi;
    String? yazarlar;
    String? kategori;

    Kitap({
        this.id,
        this.ad,
        this.kategoriId,
        this.kategoriAdi,
        this.yazarId,
        this.yayinYili,
        this.sayfaSayisi,
        this.fiyat,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
        this.adyazar,
        this.adi,
        this.yazarlar,
        this.kategori,
    });

    factory Kitap.fromJson(Map<String, dynamic> json) => Kitap(
        id: json["ID"],
        ad: json["Ad"],
        kategoriId: json["KategoriID"],
        kategoriAdi: json["KategoriAdi"],
        yazarId: json["YazarID"],
        yayinYili: json["YayinYili"],
        sayfaSayisi: json["SayfaSayisi"],
        fiyat: json["Fiyat"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        adyazar: json["Adyazar"],
        adi: json["Adi"],
        yazarlar: json["Yazarlar"],
        kategori: json["Kategori"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Ad": ad,
        "KategoriID": kategoriId,
        "KategoriAdi": kategoriAdi,
        "YazarID": yazarId,
        "YayinYili": yayinYili,
        "SayfaSayisi": sayfaSayisi,
        "Fiyat": fiyat,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "Adyazar": adyazar,
        "Adi": adi,
        "Yazarlar": yazarlar,
        "Kategori": kategori,
    };
}
