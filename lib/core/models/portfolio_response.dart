class PortfolioResponse {
  final String? type;
  final List<String>? position;

  PortfolioResponse({this.type, this.position});

  factory PortfolioResponse.fromJson(Map<String, dynamic> json) =>
      PortfolioResponse(
        type: json['type'],
        position: json["position"] == null
            ? []
            : List<String>.from(
                json["position"]!.map((x) => x),
              ),
      );
}

class UnitResponse {
  final String? type;
  final List<String>? unit;

  UnitResponse({this.type, this.unit});

  factory UnitResponse.fromJson(Map<String, dynamic> json) => UnitResponse(
        type: json['type'],
        unit: json["unit"] == null
            ? []
            : List<String>.from(
                json["unit"]!.map((x) => x),
              ),
      );
}
