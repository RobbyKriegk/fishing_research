import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/water_condition_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishingButtons extends ConsumerStatefulWidget {
  const FishingButtons({super.key});

  @override
  ConsumerState<FishingButtons> createState() => _FishingButtonsState();
}

class _FishingButtonsState extends ConsumerState<FishingButtons> {
  ButtonStyle fishingButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.backGroundDark,
    fixedSize: const Size(400, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: fishingButton,
            onPressed: () {
              ref.read(qualitiyProvider.notifier).state = 'good';
              ref.read(visibilityProvider.notifier).state = true;
            },
            child: const Text(
              'Gute Wasserqualität',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        Container(height: 10),
        ElevatedButton(
            style: fishingButton,
            onPressed: () {
              ref.read(qualitiyProvider.notifier).state = 'average';
              ref.read(visibilityProvider.notifier).state = true;
            },
            child: const Text(
              'Mittlere Wasserqualität',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        Container(height: 10),
        ElevatedButton(
            style: fishingButton,
            onPressed: () {
              ref.read(qualitiyProvider.notifier).state = 'bad';
              ref.read(visibilityProvider.notifier).state = true;
            },
            child: const Text(
              'Schlechte Wasserqualität',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        Container(height: 10),
        ElevatedButton(
            style: fishingButton,
            onPressed: () {
              ref.read(qualitiyProvider.notifier).state = 'all';
              ref.read(visibilityProvider.notifier).state = true;
            },
            child: const Text(
              'Alle Wasserqualitäten',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
      ],
    );
  }
}

final qualitiyProvider = StateProvider<String>((ref) => '');
