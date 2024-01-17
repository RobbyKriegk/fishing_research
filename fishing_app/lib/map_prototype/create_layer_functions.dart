import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/map_prototype/csv_inputs.dart';
import 'package:fishing_app/water_condition_function.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

createMarkerRoad(List<Map<String, dynamic>> localMap, String quality,
    String dateSeleted, double zoom) {
  List<Map<String, dynamic>> cuttedMap = cutMap(localMap, quality, dateSeleted);
  List<Marker> markerList = [];
  if (zoom >= 12) {
    for (int i = 0; i < cuttedMap.length; i++) {
      markerList.add(Marker(
        point: LatLng(cuttedMap[i]['lat'], cuttedMap[i]['lng']),
        width: 80,
        height: 80,
        child: Image.asset(waterCondition(cuttedMap[i]['o2'])),
      ));
    }
  } else {
    List lats = cuttedMap.map((point) => point['lat']).toList();
    List lngs = cuttedMap.map((point) => point['lng']).toList();
    List o2s = cuttedMap.map((point) => point['o2']).toList();
    if (lats.isEmpty) {
      return markerList;
    }
    var asset = median(o2s);

    markerList.add(Marker(
        point: LatLng(median(lats), median(lngs)),
        width: 80,
        height: 80,
        child: Image.asset(waterCondition(asset))));
  }
  return markerList;
}

createCircle(
    List<Map<String, dynamic>> localMap, String quality, String dateSeleted) {
  List<Map<String, dynamic>> cuttedMap = cutMap(localMap, quality, dateSeleted);
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

cutMap(
    List<Map<String, dynamic>> localMap, String quality, String dateSeleted) {
  List<Map<String, dynamic>> cutMap = [];
  String waterQuality = '';
  String date = '';
  Map<String, dynamic> qualityToImageMap = {
    'good': 'assets/images/happy_green_fish.png',
    'average': 'assets/images/yellow_fish.png',
    'bad': 'assets/images/sad_red_fish.png',
  };

  for (int i = 0; i < localMap.length; i++) {
    waterQuality = waterCondition(localMap[i]['o2']);
    date = localMap[i]['date'];

    if (date == dateSeleted &&
        (quality == 'all' || waterQuality == qualityToImageMap[quality])) {
      cutMap.add(localMap[i]);
    }
    if (dateSeleted == 'all' &&
        (quality == 'all' || waterQuality == qualityToImageMap[quality])) {
      cutMap.add(localMap[i]);
    }
  }
  return cutMap;
}
