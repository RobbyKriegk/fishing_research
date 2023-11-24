import 'package:fishing_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// build consumer statful widget
class ZoomButtons extends ConsumerStatefulWidget {
  const ZoomButtons({Key? key, required this.mapController}) : super(key: key);
  final MapController mapController;

  @override
  ConsumerState<ZoomButtons> createState() => _ZoomButtonsState();
}

class _ZoomButtonsState extends ConsumerState<ZoomButtons> {
  //code for round button
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.end,
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     children: [
  //       SizedBox(width: MediaQuery.of(context).size.width - 30),
  //       FloatingActionButton(
  //         onPressed: () {
  //           setState(() {
  //             widget.mapController.move(
  //                 widget.mapController.center, widget.mapController.zoom + 1);
  //           });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width - 30),
        FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColors.backGroundDark,
            onPressed: () {
              setState(() {
                widget.mapController.move(
                    widget.mapController.center, widget.mapController.zoom + 1);
              });
            },
            child: const Icon(Icons.add, color: Colors.white)),
        const SizedBox(height: 5),
        FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: AppColors.backGroundDark,
            onPressed: () {
              setState(() {
                widget.mapController.move(
                    widget.mapController.center, widget.mapController.zoom - 1);
              });
            },
            child: const Icon(Icons.remove, color: Colors.white)),
        const SizedBox(height: 10),
      ],
    );
  }
}
