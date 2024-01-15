import 'package:fishing_app/database_connection.dart';
import 'package:fishing_app/map_prototype/csv_inputs.dart';
import 'package:fishing_app/map_prototype/create_layer_functions.dart';
import 'package:fishing_app/map_prototype/zoom_buttons.dart';
import 'package:fishing_app/provider.dart';
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
  bool showLayer = false;
  MapController mapController = MapController();
  List<dynamic> csvData = [];

  List<Map<String, dynamic>> mapPoints = [];
  List<List<dynamic>> fields = [];

  @override
  void initState() {
    super.initState();
    csvFromServer().then((value) {
      setState(() {
        if (value != null) {
          csvData = value;
          mapPoints = csvListProcessing(value);
        }
        List<String> dates =
            mapPoints.map((point) => point['date'].toString()).toList();
        dates = dates.toSet().toList();
        ref.read(dateProvider.notifier).state = dates;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    showLayer = ref.watch(visibilityProvider);
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
        Visibility(
            visible: showLayer,
            child: CircleLayer(
                circles: createCircle(mapPoints, ref.watch(qualitiyProvider)))),
        Visibility(
            visible: showLayer,
            child: MarkerLayer(
              markers: createMarkerRoad(mapPoints, ref.watch(qualitiyProvider)),
            )),
        ZoomButtons(mapController: mapController),
      ],
    );
  }
}
