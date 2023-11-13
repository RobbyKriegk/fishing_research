import 'package:fishing_app/water_condition_function.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

createMarkerRoad(List<Map<String, dynamic>> localMap, double temp) {
  List<Marker> markerList = [];
  for (int i = 0; i < localMap.length; i++) {
    markerList.add(Marker(
      point: LatLng(localMap[i]['lat'], localMap[i]['lng']),
      width: 60,
      height: 60,
      child: Image.asset(waterCondition(temp)),
    ));
  }
  return markerList;
}
