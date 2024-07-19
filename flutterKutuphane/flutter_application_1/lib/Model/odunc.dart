import 'dart:convert';



List<Odunc> oduncListeFromJson(String str) => List<Odunc>.from(json.decode(str).map((x) => Odunc.fromJson(x)));

String oduncListeToJson(List<Odunc> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Odunc oduncFromJson(String str) => Odunc.fromJson(json.decode(str));

String oduncToJson(Odunc data) => json.encode(data.toJson());
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
  List<Odunc>? odunc;

  Paged({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    this.odunc,
  });

  factory Paged.fromJson(Map<String, dynamic> json) => Paged(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        odunc: json["Odunc"] == null
            ? []
            : List<Odunc>.from(
                json["Odunc"]!.map((x) => Odunc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "Odunc":odunc == null
            ? []
            : List<dynamic>.from(odunc!.map((x) => x.toJson())),
      };
}

class Odunc {
    int? id;
    int? kitapId;
    int? kullaniciId;
    DateTime? alisTarihi;
    DateTime? teslimTarihi;
    bool? teslimDurumu;
    String? kayitYapan;
    String? kayitTarihi;
    String? degisiklikYapan;
    String? degisiklikTarihi;
    String?  gorevliId;
    String?  gorevliAdi;
    int? yazarId;
    String? kitapAdi;
    String? kullaniciAdi;
    String? sayfaSayisi;
    String?  fiyat;
    String?  yazarAdi;
    String?  yazarSoyad;
    String?  kategoriAdi;
    String?  kategoriId;
    String? kitaplar;
    String?  kullanicilar;

    Odunc( {
        this.id,
        this.kitapId,
        this.kullaniciId,
        this.alisTarihi,
        this.teslimTarihi,
        this.teslimDurumu,
        this.kayitYapan,
        this.kayitTarihi,
        this.degisiklikYapan,
        this.degisiklikTarihi,
        this.gorevliId,
        this.gorevliAdi,
        this.yazarId,
        this.kitapAdi,
        this.kullaniciAdi,
        this.sayfaSayisi,
        this.fiyat,
        this.yazarAdi,
        this.yazarSoyad,
        this.kategoriAdi,
        this.kategoriId,
        this.kitaplar,
        this.kullanicilar,
    });

    factory Odunc.fromJson(Map<String, dynamic> json) => Odunc(
        id: json["ID"],
        kitapId: json["KitapID"],
        kullaniciId: json["KullaniciID"],
        alisTarihi: json["AlisTarihi"]== null ? null : DateTime.parse(json["AlisTarihi"]),
        teslimTarihi: json["TeslimTarihi"]== null ? null : DateTime.parse(json["TeslimTarihi"]),
        teslimDurumu: json["TeslimDurumu"],
        kayitYapan: json["KayitYapan"],
        kayitTarihi: json["KayitTarihi"],
        degisiklikYapan: json["DegisiklikYapan"],
        degisiklikTarihi: json["DegisiklikTarihi"],
        gorevliId: json["GorevliID"],
        gorevliAdi: json["GorevliAdi"],
        yazarId: json["YazarID"],
        kitapAdi: json["KitapAdi"],
        kullaniciAdi: json["KullaniciAdi"],
        sayfaSayisi: json["SayfaSayisi"],
        fiyat: json["Fiyat"],
        yazarAdi: json["YazarAdi"],
        yazarSoyad: json["YazarSoyad"],
        kategoriAdi: json["KategoriAdi"],
        kategoriId: json["KategoriID"],
        kitaplar: json["Kitaplar"],
        kullanicilar: json["Kullanicilar"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "KitapID": kitapId,
        "KullaniciID": kullaniciId,
        "AlisTarihi": alisTarihi?.toIso8601String(),
        "TeslimTarihi": teslimTarihi?.toIso8601String(),
        "TeslimDurumu": teslimDurumu,
        "KayitYapan": kayitYapan,
        "KayitTarihi": kayitTarihi,
        "DegisiklikYapan": degisiklikYapan,
        "DegisiklikTarihi": degisiklikTarihi,
        "GorevliID": gorevliId,
        "GorevliAdi": gorevliAdi,
        "YazarID": yazarId,
        "KitapAdi": kitapAdi,
        "KullaniciAdi": kullaniciAdi,
        "SayfaSayisi": sayfaSayisi,
        "Fiyat": fiyat,
        "YazarAdi": yazarAdi,
        "YazarSoyad": yazarSoyad,
        "KategoriAdi": kategoriAdi,
        "KategoriID": kategoriId,
        "Kitaplar": kitaplar,
        "Kullanicilar": kullanicilar,
    };
}
