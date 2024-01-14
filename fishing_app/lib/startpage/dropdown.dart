import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/startpage/fishing_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dropdown extends ConsumerStatefulWidget {
  const Dropdown({super.key});

  @override
  ConsumerState<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends ConsumerState<Dropdown> {
  List<DropdownMenuEntry> items2 = [
    const DropdownMenuEntry(
      value: 'good',
      label: 'Gute Wasserqualität',
    ),
    const DropdownMenuEntry(
      value: 'average',
      label: 'Mittlere Wasserqualität',
    ),
    const DropdownMenuEntry(
      value: 'bad',
      label: 'Schlechte Wasserqualität',
    ),
    const DropdownMenuEntry(
      value: 'all',
      label: 'Alle Wasserqualitäten',
    ),
  ];

  List<DropdownMenuEntry> dates = [
    const DropdownMenuEntry(value: 'first day', label: 'first day')
  ];

  ButtonStyle fishingButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.backGroundDark,
    fixedSize: const Size(400, 60),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
  );

  InputDecorationTheme dropdownTheme = const InputDecorationTheme(
    filled: true,
    suffixIconColor: Colors.white,
    fillColor: AppColors.backGroundDark,
    labelStyle: TextStyle(color: Colors.white),
    floatingLabelStyle: TextStyle(color: Colors.black, fontSize: 20),
    helperStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu(
            inputDecorationTheme: dropdownTheme,
            label: const Text('Wasserqualität label'),
            helperText: 'Wähle eine Wasserqualität aus',
            menuStyle: const MenuStyle(
              alignment: Alignment.center,
            ),
            hintText: 'Wasserqualität',
            width: 390,
            dropdownMenuEntries: items2),
        const SizedBox(height: 40),
        DropdownMenu(
            inputDecorationTheme: dropdownTheme,
            label: const Text('Datum'),
            width: 390,
            dropdownMenuEntries: dates),
      ],
    );
  }
}
