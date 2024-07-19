import 'dart:convert';

List<Paged> pagedListeFromJson(String str) =>
    List<Paged>.from(json.decode(str).map((x) => Paged.fromJson(x)));

String pagedListeToJson(List<Paged> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Paged pagedFromJson(String str) => Paged.fromJson(json.decode(str));

String pagedToJson(Paged data) => json.encode(data.toJson());

Kategori kategoriFromJson(String str) => Kategori.fromJson(json.decode(str));

String kategoriToJson(Kategori data) => json.encode(data.toJson());

List<Kategori> kategoriLFromJson(String str) =>
    List<Kategori>.from(json.decode(str).map((x) => Kategori.fromJson(x)));

String kategoriLToJson(List<Kategori> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Paged {
  int? totalCount;
  int? pageSize;
  int? currentPage;
  int? totalPages;
  List<Kategori>? kategori;

  Paged({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    this.kategori,
  });

  factory Paged.fromJson(Map<String, dynamic> json) => Paged(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        kategori: json["Kategori"] == null
            ? []
            : List<Kategori>.from(
                json["Kategori"]!.map((x) => Kategori.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "Kategori": kategori == null
            ? []
            : List<dynamic>.from(kategori!.map((x) => x.toJson())),
      };
}

class Kategori {
  String? adi;
  int? id;

  Kategori({
    this.adi,
    this.id,
  });

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        adi: json["Adi"],
        id: json["ID"],   
      );

  Map<String, dynamic> toJson() => {
        "Adi": adi,
        "ID": id,
      };
}
