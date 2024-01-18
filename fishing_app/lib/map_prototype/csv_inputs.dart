import "package:csv/csv.dart";
import "package:fishing_app/map_prototype/create_layer_functions.dart";
import "package:fishing_app/map_prototype/get_distance.dart";

Future<List<List<dynamic>>> csvListCreator(List csvData) async {
  List<List<dynamic>> fields = [];
  for (int i = 0; i < csvData.length; i++) {
    final input = await csvData[i];
    fields.add(const CsvToListConverter().convert(input));
  }
  return fields;
}

csvListProcessing(List<List<dynamic>> fields) {
  List<Map<String, dynamic>> localMap = [];
  double medianLat = 0;
  double medianLng = 0;
  double distance = 0;
  double medianO2 = 0;
  for (int i = 0; i < fields.length; i++) {
    List pointsList = [];
    List latList = [];
    List lngList = [];
    List o2List = [];
    List dateList = [];
    List timeList = [];
    for (int k = 1; k < fields[i].length; k++) {
      // get o2 values
      double o2 = double.parse(fields[i][k][9]);
      o2List.add(o2);
      // get dates + times
      String date = fields[i][k][1];
      String time = date.substring(11, 19);
      date = date.substring(0, 10);
      dateList.add(date);
      timeList.add(time);
      // get lat/lng points
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
    medianO2 = average(o2List);
    localMap.add({
      'lat': medianLat,
      'lng': medianLng,
      'o2': medianO2,
      'date': dateList[i],
      'time': timeList[timeList.length ~/ 2],
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
  return localMap;
}
