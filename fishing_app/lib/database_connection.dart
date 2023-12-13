import 'dart:async';
import 'package:mysql1/mysql1.dart';

Future fetchData() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'hyfive.info',
      port: 3306,
      user: 'student',
      db: 'hyFiveDB',
      password: 'student0815'));

  var loggerId = 5;
  var deploymentId = 176;

// TODO: query dont work with locationFunction -> need to solve
//       implement more of the pythopn file

  var queryRawValues = await conn.query(
      'SELECT deployment_id, sensor_id, logger_id, measuring_time, ST_X(measuring_location) as lng_coordinate, ST_Y(measuring_location) as lat_coordinate, pressure, value FROM RawValue WHERE logger_id = ? AND deployment_id = ?',
      [loggerId, deploymentId]);

// print all values from queryRawValues
  for (var row in queryRawValues) {
    if (queryRawValues.isEmpty) {
      print('No data available');
    } else {
      print(
          'Deployment ID: ${row[0]}, Sensor ID: ${row[1]}, Logger ID: ${row[2]}, Measuring Time: ${row[3]}, Lng_coordinate: ${row[4]}, Lat_coordinate: ${row[5]}, Pressure: ${row[6]}, value: ${row[7]} ');
    }
  }
// <5>

  // Finally, close the connection
  await conn.close();
}
