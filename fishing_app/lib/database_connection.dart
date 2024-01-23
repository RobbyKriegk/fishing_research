import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future csvFromServer() async {
  List<dynamic> jsonResponse;
  List<List<dynamic>> csvData = [];
  final conn =
      // await http.get(Uri.parse('http://192.168.178.107:3000/database-data/'));
      await http.get(Uri.parse('http://10.222.9.249:3000/database-data/'));
  // await http.get(Uri.parse('http://139.30.33.55:3000/database-data/'));
  if (conn.statusCode == 200) {
    jsonResponse = jsonDecode(conn.body);
    csvData = jsonResponse
        .map<List<dynamic>>((item) => List<dynamic>.from(item))
        .toList();
    return csvData;
  } else {
    print('Request failed with status: ${conn.statusCode}.');
  }
}
