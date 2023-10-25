import 'dart:convert';

import 'package:rcf_attendance_generator/core/models/portfolio_response.dart';

import 'zone_model.dart';

BaseZoneResponse zoneFromJson(String str) =>
    BaseZoneResponse.fromJson(json.decode(str));

String zoneToJson(BaseZoneResponse data) => json.encode(data.toJson());

class BaseZoneResponse<T> {
  final String? code;
  final String? message;
  // final List<RcfZones>? data;
  final T? data;

  BaseZoneResponse({
    this.code,
    this.message,
    this.data,
  });

  factory BaseZoneResponse.fromJson(Map<String, dynamic> json) =>
      BaseZoneResponse(
        code: json["code"],
        message: json["message"],
        // data: json["data"] == null ? [] : List<RcfZones>.from(json["data"]!.map((x) => RcfZones.fromJson(x))),
        data: _Converter<T>().fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        // "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class _Converter<T> {
  const _Converter();

  T? fromJson(Object? json) {
    if (json == null) return null;
    if (json is List) {
      if (json.isNotEmpty) {
        var item = json.first;
        if (item is Map<String, dynamic> &&
            item.containsKey('zone') &&
            item.containsKey('institutions')) {
          return json
              .map((i) => RcfZones.fromJson(i as Map<String, dynamic>))
              .toList() as T;
        }
      } else {
        return null;
      }
    } else {
      if (json is Map<String, dynamic> &&
          json.containsKey('type') &&
          json.containsKey('position')) {
        return PortfolioResponse.fromJson(json) as T;
      } else if (json is Map<String, dynamic> &&
          json.containsKey('type') &&
          json.containsKey('unit')) {
        return UnitResponse.fromJson(json) as T;
      } else {
        return json.toString() as T;
      }
    }
    return null;
  }

  Object? toJson(T object) {
    return object;
  }
}
