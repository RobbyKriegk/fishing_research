import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/water_condition_function.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

createMarkerRoad(List<Map<String, dynamic>> localMap, String quality) {
  List<Map<String, dynamic>> cuttedMap = cutMap(localMap, quality);
  List<Marker> markerList = [];
  for (int i = 0; i < cuttedMap.length; i++) {
    markerList.add(Marker(
      point: LatLng(cuttedMap[i]['lat'], cuttedMap[i]['lng']),
      width: 80,
      height: 80,
      child: Image.asset(waterCondition(cuttedMap[i]['o2'])),
    ));
  }
  return markerList;
}

createCircle(List<Map<String, dynamic>> localMap, String quality) {
  List<Map<String, dynamic>> cuttedMap = cutMap(localMap, quality);
  List<CircleMarker> circleList = [];
  for (int i = 0; i < cuttedMap.length; i++) {
    circleList.add(CircleMarker(
        useRadiusInMeter: true,
        point: LatLng(cuttedMap[i]['lat'], cuttedMap[i]['lng']),
        color: const Color.fromARGB(255, 244, 67, 54).withOpacity(0.2),
        radius: cuttedMap[i]['distance'] ?? 0,
        borderStrokeWidth: 2,
        borderColor: AppColors.backGroundDark.withOpacity(0.6)));
  }

  return circleList;
}

cutMap(List<Map<String, dynamic>> localMap, String quality) {
  List<Map<String, dynamic>> cutMap = [];
  for (int i = 0; i < localMap.length; i++) {
    if (quality == 'good' &&
        waterCondition(localMap[i]['o2']) ==
            'assets/images/happy_green_fish.png') {
      cutMap.add(localMap[i]);
    } else if (quality == 'average' &&
        waterCondition(localMap[i]['o2']) == 'assets/images/yellow_fish.png') {
      cutMap.add(localMap[i]);
    } else if (quality == 'bad' &&
        waterCondition(localMap[i]['o2']) == 'assets/images/sad_red_fish.png') {
      cutMap.add(localMap[i]);
    } else if (quality == 'all') {
      cutMap.add(localMap[i]);
    }
  }
  return cutMap;
}
