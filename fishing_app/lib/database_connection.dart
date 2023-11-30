import 'dart:async';
import 'package:mysql1/mysql1.dart';

Future fetchData() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'hyfive.info',
      port: 3306,
      user: 'student',
      db: 'hyFiveDB',
      password: 'student0815'));

  var result = await conn.query('select deployment_id from Deployment');

  print(result);

  // Finally, close the connection
  await conn.close();
}
