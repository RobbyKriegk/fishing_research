import 'package:fishing_app/app_colors.dart';
import 'package:flutter/material.dart';

class FishingButtons extends StatefulWidget {
  const FishingButtons({super.key});

  @override
  State<FishingButtons> createState() => _FishingButtonsState();
}

class _FishingButtonsState extends State<FishingButtons> {
  fishingButton(String buttonText) {
    return ElevatedButton(
        // border
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backGroundDark,
          fixedSize: const Size(400, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: () {},
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        fishingButton('Button 1'),
        Container(height: 10),
        fishingButton('Button 2'),
        Container(height: 10),
        fishingButton('Button 3'),
        Container(height: 10),
        fishingButton('Button 4'),
      ],
    );
  }
}
