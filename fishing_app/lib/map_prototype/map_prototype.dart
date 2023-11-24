import 'package:fishing_app/map_prototype/csv_inputs.dart';
import 'package:fishing_app/map_prototype/create_layer_functions.dart';
import 'package:fishing_app/map_prototype/zoom_buttons.dart';
import 'package:fishing_app/water_condition_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapPrototype extends ConsumerStatefulWidget {
  const MapPrototype({super.key});

  @override
  ConsumerState<MapPrototype> createState() => _MapPrototypeState();
}

class _MapPrototypeState extends ConsumerState<MapPrototype> {
  MapController mapController = MapController();
  List<String> csvData = [
    'assets/csv_data/sensordata.csv',
    'assets/csv_data/sensordata_2.csv',
    'assets/csv_data/sensordata_3.csv',
    'assets/csv_data/sensordata_4.csv',
    'assets/csv_data/sensordata_5.csv',
    'assets/csv_data/sensordata_6.csv',
    'assets/csv_data/sensordata_7.csv',
    'assets/csv_data/sensordata_8.csv',
    'assets/csv_data/sensordata_9.csv',
    'assets/csv_data/sensordata_10.csv',
    'assets/csv_data/sensordata_11.csv',
    'assets/csv_data/sensordata_12.csv',
    'assets/csv_data/sensordata_13.csv',
    'assets/csv_data/sensordata_14.csv',
    'assets/csv_data/sensordata_15.csv',
    'assets/csv_data/sensordata_16.csv',
    'assets/csv_data/sensordata_17.csv',
  ];
  // MapCamera mapCamera = MapCamera(
  //   zoom: 8,
  // );

  List<Map<String, dynamic>> mapPoints = [];
  List<List<dynamic>> fields = [];

  @override
  void initState() {
    super.initState();
    csvListCreator(csvData).then((value) {
      setState(() {
        fields = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (fields.isNotEmpty) {
      mapPoints = csvListProcessing(fields);
    }
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
        CircleLayer(circles: createCircle(mapPoints)),
        // MarkerLayer(
        //   markers: createMarkerRoad(mapPoints, ref.watch(tempProvider)),
        // ),
        ZoomButtons(mapController: mapController),
      ],
    );
  }
}
