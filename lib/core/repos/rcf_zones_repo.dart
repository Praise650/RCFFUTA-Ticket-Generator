import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/base_response.dart';
import '../models/portfolio_response.dart';
import '../models/zone_model.dart';

class RcfZonesRepo{
  List<RcfZones> _zones = [];
  List<Institution> _institutionList = [];
  List<String> _units = [];
  List<String> _positions = [];
  RcfZones? _selectedZone;
  
  // getters
  List<RcfZones> get zones => _zones;
  List<String> get units => _units;
  List<String> get positions => _positions;


  Future<void> fetchData() async{
    _zones = await _getZones();
      await _getUnits().then((value) => _units = value.unit!);
      await _getPositions().then((value) => _positions = value.position!);
    for (var rcfZone in _zones) {
      print("In the zone ${rcfZone.zone}");
    }
    for (var unit in _units) {
      print("In the zone $unit");
    }
    for (var position in _positions) {
      print("In the zone $position");
    }
  }

  Future<void> fetchInstitutions(RcfZones value)async{
    _selectedZone = value;
    _institutionList = _selectedZone!.institutions!;
    for (var rcfZone in _institutionList) {
      print("In the zone ${rcfZone.fellowshipName}");
    }
  }

  Future<List<RcfZones>> _getZones() async{
    final jsonData = await rootBundle.loadString('assets/jsons/rcf_zones.json');
    final res = jsonDecode(jsonData) as Map<String,dynamic>;
    final value = BaseZoneResponse<List<RcfZones>>.fromJson(res);
    return value.data!;
  }

  Future<UnitResponse> _getUnits() async{
    final jsonData = await rootBundle.loadString('assets/jsons/unit.json');
    final res = jsonDecode(jsonData) as Map<String,dynamic>;
    final value =  BaseZoneResponse<UnitResponse>.fromJson(res);
    return value.data!;
  }

  Future<PortfolioResponse> _getPositions() async{
    final jsonData = await rootBundle.loadString('assets/jsons/executives.json');
    final res = jsonDecode(jsonData) as Map<String,dynamic>;
    final value =  BaseZoneResponse<PortfolioResponse>.fromJson(res);
    return value.data!;
  }
}