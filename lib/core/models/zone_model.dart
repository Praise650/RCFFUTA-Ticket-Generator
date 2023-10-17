class RcfZones {
  final String? zone;
  final List<Institution>? institutions;

  RcfZones({
    this.zone,
    this.institutions,
  });

  factory RcfZones.fromJson(Map<String, dynamic> json) => RcfZones(
    zone: json["zone"],
    institutions: json["institutions"] == null ? [] : List<Institution>.from(json["institutions"]!.map((x) => Institution.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zone": zone,
    "institutions": institutions == null ? [] : List<dynamic>.from(institutions!.map((x) => x.toJson())),
  };
}

class Institution {
  final String? fellowshipName;
  final dynamic schoolName;
  final String? zone;
  final String? institutions;
  // final String? schoolName;
  final int? id;


  Institution({
    this.fellowshipName,
    this.schoolName,
    this.zone,
    this.institutions,
    // this.schoolName,
    this.id,
  });

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
    fellowshipName: json["fellowshipName"],
    schoolName: json["schoolName"],
    zone: json["zone"],
    institutions: json["institutions"],
    // schoolName: json['schoolName']
  );

  Map<String, dynamic> toJson() => {
    "fellowshipName": fellowshipName,
    "schoolName": schoolName,
    "zone": zone,
    "institutions": institutions,
  };
}