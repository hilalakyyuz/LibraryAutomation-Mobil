class Gorevli {
  String adSoyad;
  String sifre;
  int? id;

  Gorevli({
    required this.adSoyad,
    required this.sifre,
    required this.id,
  });

  factory Gorevli.fromJson(Map<String, dynamic> json) {
    return Gorevli(
      adSoyad: json['adSoyad'] ?? '', 
      sifre: json['sifre'] ?? '', 
      id: json['id'] != null ? json['id'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adSoyad'] = adSoyad;
    data['sifre'] = sifre;
    data['id'] = id;
    return data;
  }
}
