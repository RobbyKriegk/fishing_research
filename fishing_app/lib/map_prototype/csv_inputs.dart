import "package:csv/csv.dart";
import "package:fishing_app/map_prototype/get_distance.dart";
import "package:flutter/services.dart";

Future<List<List<dynamic>>> csvListCreator(List<String> csvData) async {
  List<List<dynamic>> fields = [];
  for (int i = 0; i < csvData.length; i++) {
    final input = await rootBundle.loadString(csvData[i]);
    fields.add(const CsvToListConverter().convert(input));
  }
  return fields;
}

double median(List a) {
  var middle = a.length ~/ 2;
  if (a.length % 2 == 1) {
    return a[middle];
  } else {
    return (a[middle - 1] + a[middle]) / 2.0;
  }
}

csvListProcessing(List<List<dynamic>> fields) {
  List<Map<String, dynamic>> localMap = [];
  List pointsList = [];
  List latList = [];
  List lngList = [];
  double medianLat = 0;
  double medianLng = 0;
  double distance = 0;
  for (int i = 0; i < fields.length; i++) {
    latList = [];
    lngList = [];
    for (int k = 1; k < fields[i].length; k++) {
      String pointString = fields[i][k][2];
      pointString = pointString.replaceAll('POINT', '');
      pointString = pointString.replaceAll('(', '');
      pointString = pointString.replaceAll(')', '');
      pointsList = pointString.split(' ');
      latList.add(double.parse(pointsList[1]));
      lngList.add(double.parse(pointsList[0]));
    }
    medianLat = median(latList);
    medianLng = median(lngList);
    localMap.add({
      'lat': medianLat,
      'lng': medianLng,
    });

    for (int i = 0; i < latList.length; i++) {
      double checkDistance =
          GeoUtils.haversine(medianLat, medianLng, latList[i], lngList[i]);
      if (checkDistance > distance) {
        distance = checkDistance;
      }
    }
    localMap[i]['distance'] = distance;
  }
  print(localMap.length);
  print(localMap);
  return localMap;
}
