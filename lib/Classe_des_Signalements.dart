class Signalement {
  String? region;
  String? ville;
  String? quartier;
  String? description;
  DateTime? date;
  String? photo;
  bool? esttraite;
  Signalement({
    this.description,
    this.region,
    this.ville,
    this.quartier,
    this.date,
    this.esttraite,
    this.photo,
  });
  //CLES RECUES DE PHP : (idSignals, esttraite, Description, Region, Ville, Quartier, ..., Date, idUser)
  factory Signalement.fromJson(Map<String, dynamic> json) {
    return Signalement(
      description: json['Description'] ?? "",
      photo: json['photo'],
      date: json['Date'] != null ? DateTime.parse(json['Date']) : null,
      ville: json['Ville'] ?? "",
      region: json['Region'] ?? "",
      quartier: json['Quartier'] ?? "",
      // Conversion intelligente du booléen (PHP renvoie souvent "1" ou "0")
      esttraite:
          (json['esttraite'].toString() == '1' ||
          json['esttraite'].toString() == 'true'),
    );
  }
}
