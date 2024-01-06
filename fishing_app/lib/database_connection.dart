import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;

Future fetchData() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'hyfive.info',
      port: 3306,
      user: 'student',
      db: 'hyFiveDB',
      password: 'student0815'));

  int loggerId;
  int deplIDStart = 152;
  int deplIDEnd = 177;
  List rawValues = [];
  List sensors = [];
  List parameter = [];
  Map<String, dynamic> dataNewFrame = {
    'sensorID': [],
    'parameter': [],
    'value': [],
    'time': [],
    'lng': [],
    'lat': [],
    'pressure': [],
  };

//       implement more of the pythopn file
  for (int i = deplIDStart; i < deplIDEnd; i++) {
    print('Deployment ID: $i');
    loggerId = 5;

    var queryRawValues = await conn.query(
        'SELECT deployment_id, sensor_id, logger_id, measuring_time, ST_X(measuring_location) as lng_coordinate, ST_Y(measuring_location) as lat_coordinate, pressure, value FROM RawValue WHERE logger_id = ? AND deployment_id = ?',
        [loggerId, i]);

    for (var row in queryRawValues) {
      rawValues.add(row);
    }

    for (int j = 0; j < 3; j++) {
      sensors.add(rawValues[j][1]);
    }

    print(sensors);

    for (int j = 0; j < sensors.length; j++) {
      var querySensors = await conn.query(
          'SELECT st.parameter FROM SensorType st JOIN Sensor s ON st.sensor_type_id = s.sensor_type_id WHERE s.sensor_id = ?',
          [j]);
      for (var row in querySensors) {
        parameter.add(row);
      }
    }

    for (int j = 0; j < rawValues.length; j++) {
      if (sensors.isNotEmpty) {
        if (rawValues.elementAt(j)[1] == sensors[0]) {
          dataNewFrame['time'].add(rawValues[j][3]);
          dataNewFrame['lng'].add(rawValues[j][4]);
          dataNewFrame['lat'].add(rawValues[j][5]);
          dataNewFrame['pressure'].add(rawValues[j][6]);
        }
      } else {
        print('empty');
      }
    }
  }
  print(dataNewFrame);

// print all values from queryRawValues

  // Finally, close the connection
  await conn.close();
}

Future csvFromServer() async {
  var jsonResponse;
  List<List<dynamic>> csvData = [];
  final conn =
      await http.get(Uri.parse('https://fishing-app-backend.vercel.app/'));
  if (conn.statusCode == 200) {
    jsonResponse = jsonDecode(conn.body);
    csvData = jsonResponse
        .map<List<dynamic>>((item) => List<dynamic>.from(item))
        .toList();
    for (int i = 0; i < csvData.length; i++) {
      print(csvData[i].length);
    }
    return csvData;
  } else {
    print('Request failed with status: ${conn.statusCode}.');
  }
}
