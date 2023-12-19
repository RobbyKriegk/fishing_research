import 'dart:async';
import 'package:mysql1/mysql1.dart';

Future fetchData() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'hyfive.info',
      port: 3306,
      user: 'student',
      db: 'hyFiveDB',
      password: 'student0815'));

  int loggerId;
  int deploymentId;
  List rawValues = [];
  List sensors = [];
  Map<String, dynamic> dataNewFrame = {
    'time': [],
    'lng': [],
    'lat': [],
    'pressure': [],
  };

//       implement more of the pythopn file
  for (int i = 152; i < 153; i++) {
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

    print(dataNewFrame['time'].length);
  }

// print all values from queryRawValues

  // Finally, close the connection
  await conn.close();
}
