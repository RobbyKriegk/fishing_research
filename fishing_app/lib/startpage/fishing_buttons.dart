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
  fishingButton(String buttonText, double temp) {
    return ElevatedButton(
        // border
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backGroundDark,
          fixedSize: const Size(400, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: () {
          setState(() {
            ref.read(tempProvider.notifier).state = temp;
            ref.read(visibilityProvider.notifier).state = true;
          });
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        fishingButton('Super Wasser', 15),
        Container(height: 10),
        fishingButton('Gutes Wasser', 20),
        Container(height: 10),
        fishingButton('Schlechtes Wasser', 30),
        Container(height: 10),
        fishingButton('Eiswasser', 0),
      ],
    );
  }
}
