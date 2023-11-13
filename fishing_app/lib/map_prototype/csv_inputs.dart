import "package:csv/csv.dart";
import "package:flutter/services.dart";

Future<List<Map<String, dynamic>>> csvListCreator(
    String csv, List<Map<String, dynamic>> localMap) async {
  List pointsList = [];
  final input = await rootBundle.loadString(csv);
  final fields = const CsvToListConverter().convert(input);
  for (int i = 1; i < fields.length; i++) {
    String pointString = fields[i][2];
    pointString = pointString.replaceAll('POINT', '');
    pointString = pointString.replaceAll('(', '');
    pointString = pointString.replaceAll(')', '');
    pointsList = pointString.split(' ');
    localMap.add({
      'lat': double.parse(pointsList[1]),
      'lng': double.parse(pointsList[0]),
    });
  }
  //print(localMap);
  return localMap;
}
