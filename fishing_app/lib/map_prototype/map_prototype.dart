import 'package:fishing_app/map_prototype/csv_inputs.dart';
import 'package:fishing_app/map_prototype/marker_layer_list.dart';
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
  // MapCamera mapCamera = MapCamera(
  //   zoom: 8,
  // );

  List<Map<String, dynamic>> mapPoints = [];

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
        CircleLayer(circles: createCircle(mapPoints, 1000)),
        MarkerLayer(
          markers: createMarkerRoad(mapPoints, ref.watch(tempProvider)),
        ),
        ZoomButtons(mapController: mapController),
      ],
    );
  }
}
