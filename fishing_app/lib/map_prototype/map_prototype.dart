import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:fishing_app/map_prototype/zoom_buttons.dart';
import 'package:flutter/material.dart';
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

    final input = File(csv).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
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
      // if (localMap.isEmpty) {
      //   localMap.add({
      //     'lat': 53.998308,
      //     'lng': 10.974112,
      //   });
      // }
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

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     csvListCreator(
  //         '/Users/robbykriegk/Desktop/development/05-app-fishen-a/fishing_app/assets/logger_5_deployment_152.csv',
  //         mapPoints);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    csvListCreator(
        '/Users/robbykriegk/Desktop/development/05-app-fishen-a/fishing_app/assets/logger_5_deployment_152.csv',
        mapPoints);
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
        Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  fixedSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  mapController.move(
                      mapController.center, mapController.zoom + 1);
                },
                child: const Icon(Icons.add, color: Colors.white)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  fixedSize: const Size(50, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () {
                  mapController.move(
                      mapController.center, mapController.zoom - 1);
                },
                child: const Icon(Icons.minimize, color: Colors.white)),
          ],
        )
      ],
    );
  }
}
