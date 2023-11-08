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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(54, 12),
        initialZoom: 10,
        interactionOptions: InteractionOptions(
          pinchMoveWinGestures: 13,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=O8whOpzaILpG8fOEB2Fz',
          userAgentPackageName: 'unknown',
          // Plenty of other options available!
        ),
      ],
    );
  }
}
