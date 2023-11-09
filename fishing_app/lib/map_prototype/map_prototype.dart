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

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
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
          markers: [
            Marker(
              point: LatLng(53.998308, 10.974112),
              width: 80,
              height: 80,
              child: Image.asset('assets/images/freudiger_fisch.png'),
            ),
          ],
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
