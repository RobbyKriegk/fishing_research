import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:fishing_app/map_prototype/zoom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPrototype extends StatefulWidget {
  const MapPrototype({super.key});

  @override
  State<MapPrototype> createState() => _MapPrototypeState();
}

class _MapPrototypeState extends State<MapPrototype> {
  MapController mapController = MapController();
  // MapCamera mapCamera = MapCamera(
  //   zoom: 8,
  // );
  List<Map<String, dynamic>> mapPoints = [];

  Future<List<Map<String, dynamic>>> csvListCreator(
      String csv, List<Map<String, dynamic>> localMap) async {
    List pointsList = [];

    final input = await rootBundle.loadString(csv);
    // final fields = await input
    //     .transform(utf8.decoder)
    //     .transform(const CsvToListConverter())
    //     .toList();
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

  createMarkerRoad(List<Map<String, dynamic>> localMap) {
    List<Marker> markerList = [];
    for (int i = 0; i < localMap.length; i++) {
      setState(() {
        markerList.add(Marker(
          point: LatLng(localMap[i]['lat'], localMap[i]['lng']),
          width: 60,
          height: 60,
          child: Image.asset('assets/images/freudiger_fisch.png'),
        ));
      });
    }
    return markerList;
  }

  @override
  Widget build(BuildContext context) {
    csvListCreator('assets/csv_data/sensordata.csv', mapPoints);
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
        initialCenter: LatLng(54, 12),
        initialZoom: 10,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=O8whOpzaILpG8fOEB2Fz',
          userAgentPackageName: 'unknown',
        ),
        MarkerLayer(
          markers: createMarkerRoad(mapPoints),
        ),
        ZoomButtons(mapController: mapController),
      ],
    );
  }
}
