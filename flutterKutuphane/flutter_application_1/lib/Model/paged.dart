import 'dart:convert';

List<Paged> pagedListFromJson(String str) =>
    List<Paged>.from(json.decode(str).map((x) => Paged.fromJson(x)));

String pagedListToJson(List<Paged> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Paged pagedFromJson(String str) => Paged.fromJson(json.decode(str));

String pagedToJson(Paged data) => json.encode(data.toJson());

class Paged<T> {
  int? totalCount;
  int? pageSize;
  int? currentPage;
  int? totalPages;
  List<T> items;

  Paged({
    this.totalCount,
    this.pageSize,
    this.currentPage,
    this.totalPages,
    required this.items,
  });

  factory Paged.fromJson(Map<String, dynamic> json) => Paged(
        totalCount: json["TotalCount"],
        pageSize: json["PageSize"],
        currentPage: json["CurrentPage"],
        totalPages: json["TotalPages"],
        items: json["Items"] == null
            ? []
            : List<T>.from(json["Items"].map((x) => x as T)), 
      );

  Map<String, dynamic> toJson() => {
        "TotalCount": totalCount,
        "PageSize": pageSize,
        "CurrentPage": currentPage,
        "TotalPages": totalPages,
        "Items": List<dynamic>.from(items.map((x) => x)), 
      };
}
