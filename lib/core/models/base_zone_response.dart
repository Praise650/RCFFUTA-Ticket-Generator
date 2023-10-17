import 'dart:convert';

import 'zone_model.dart';

BaseZoneResponse zoneFromJson(String str) => BaseZoneResponse.fromJson(json.decode(str));

String zoneToJson(BaseZoneResponse data) => json.encode(data.toJson());

class BaseZoneResponse {
  final String? code;
  final String? message;
  final List<RcfZones>? data;

  BaseZoneResponse({
    this.code,
    this.message,
    this.data,
  });

  factory BaseZoneResponse.fromJson(Map<String, dynamic> json) => BaseZoneResponse(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<RcfZones>.from(json["data"]!.map((x) => RcfZones.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}