import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/map_prototype/csv_inputs.dart';
import 'package:fishing_app/map_prototype/get_distance.dart';
import 'package:fishing_app/water_condition_function.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

createMarkerRoad(List<Map<String, dynamic>> localMap, String quality,
    String dateSeleted, double zoom, List<Map<String, dynamic>> city) {
  List<Map<String, dynamic>> filteredMap =
      filterMap(localMap, quality, dateSeleted);
  List<Map<String, dynamic>> sortedMap = sortCitiesMap(filteredMap, city);
  List<Marker> markerList = [];
  //---------------------------------------------------------------------------
  if (sortedMap.isEmpty) {
    return markerList;
  }
  for (int j = 0; j < sortedMap.length; j++) {
    List<Map<String, dynamic>> tempMap = sortedMap[j]['maps'];
    if (zoom >= 12) {
      for (int i = 0; i < tempMap.length; i++) {
        markerList.add(Marker(
          point: LatLng(tempMap[i]['lat'], tempMap[i]['lng']),
          width: 80,
          height: 80,
          child: Image.asset(waterCondition(tempMap[i]['o2'])),
        ));
      }
    } else {
      if (quality == 'all') {
        print('test');
        List<Map<String, dynamic>> goodMap = [];
        List<Map<String, dynamic>> averageMap = [];
        List<Map<String, dynamic>> badMap = [];
        for (int i = 0; i < tempMap.length; i++) {
          if (waterCondition(tempMap[i]['o2']) ==
              'assets/images/happy_green_fish.png') {
            goodMap.add(tempMap[i]);
          } else if (waterCondition(tempMap[i]['o2']) ==
              'assets/images/yellow_fish.png') {
            averageMap.add(tempMap[i]);
          } else {
            badMap.add(tempMap[i]);
          }
        }
        print(goodMap.length);
        if (goodMap.isNotEmpty) {
          List lats = goodMap.map((point) => point['lat']).toList();
          List lngs = goodMap.map((point) => point['lng']).toList();
          List o2s = goodMap.map((point) => point['o2']).toList();
          markerList.add(Marker(
              point: LatLng(median(lats), median(lngs)),
              width: 80,
              height: 80,
              child: Image.asset(waterCondition(median(o2s)))));
        }
        if (averageMap.isNotEmpty) {
          List lats = averageMap.map((point) => point['lat']).toList();
          List lngs = averageMap.map((point) => point['lng']).toList();
          List o2s = averageMap.map((point) => point['o2']).toList();
          markerList.add(Marker(
              point: LatLng(median(lats), median(lngs)),
              width: 80,
              height: 80,
              child: Image.asset(waterCondition(median(o2s)))));
        }
        if (badMap.isNotEmpty) {
          List lats = badMap.map((point) => point['lat']).toList();
          List lngs = badMap.map((point) => point['lng']).toList();
          List o2s = badMap.map((point) => point['o2']).toList();
          markerList.add(Marker(
              point: LatLng(median(lats), median(lngs)),
              width: 80,
              height: 80,
              child: Image.asset(waterCondition(median(o2s)))));
        }
      } else {
        List lats = tempMap.map((point) => point['lat']).toList();
        List lngs = tempMap.map((point) => point['lng']).toList();
        List o2s = tempMap.map((point) => point['o2']).toList();

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
    }
  }
  // for (int i = 0; i < markerList.length; i++) {
  //   print(markerList[i].point);
  // }
  return markerList;
}

createCircle(List<Map<String, dynamic>> localMap, String quality,
    String dateSeleted, double zoom) {
  List<Map<String, dynamic>> filteredMap =
      filterMap(localMap, quality, dateSeleted);
  List<CircleMarker> circleList = [];
  for (int i = 0; i < filteredMap.length; i++) {
    circleList.add(CircleMarker(
        useRadiusInMeter: true,
        point: LatLng(filteredMap[i]['lat'], filteredMap[i]['lng']),
        color: const Color.fromARGB(255, 244, 67, 54).withOpacity(0.2),
        radius: filteredMap[i]['distance'] ?? 0,
        borderStrokeWidth: 2,
        borderColor: AppColors.backGroundDark.withOpacity(0.6)));
  }

  return circleList;
}

filterMap(
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

sortCitiesMap(
    List<Map<String, dynamic>> localMap, List<Map<String, dynamic>> cities) {
  List<Map<String, dynamic>> sortedMap = [];
  List<Map<String, dynamic>> distances = [];
  for (int i = 0; i < cities.length; i++) {
    sortedMap
        .add({'city': cities[i]['city'], 'maps': <Map<String, dynamic>>[]});
    distances.add({'city': cities[i]['city'], 'distances': []});
    for (int k = 0; k < localMap.length; k++) {
      double distance = GeoUtils.haversine(cities[i]['lat'], cities[i]['lng'],
          localMap[k]['lat'], localMap[k]['lng']);
      distances[i]['distances'].add(distance);
    }
    for (int m = 0; m < distances[i]['distances'].length; m++) {
      if (distances[i]['distances'][m] < 40000) {
        sortedMap[i]['maps'].add(localMap[m]);
      }
    }
  }

  return sortedMap;
}

double median(List a) {
  var middle = a.length ~/ 2;
  if (a.length % 2 == 1) {
    return a[middle];
  } else {
    return (a[middle - 1] + a[middle]) / 2.0;
  }
}

double average(List a) {
  double sum = 0;
  for (int i = 0; i < a.length; i++) {
    sum += a[i];
  }
  return sum / a.length;
}
