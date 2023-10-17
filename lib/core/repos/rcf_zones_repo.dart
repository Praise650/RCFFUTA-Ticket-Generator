import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/base_zone_response.dart';

class RcfZonesRepo{
  Future<BaseZoneResponse> getZones() async{
    final jsonData = await rootBundle.loadString('assets/jsons/rcf_zones.json');
    final res = jsonDecode(jsonData) as Map<String,dynamic>;
    return BaseZoneResponse.fromJson(res);
  }
}