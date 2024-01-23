import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dropdown extends ConsumerStatefulWidget {
  const Dropdown({super.key});

  @override
  ConsumerState<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends ConsumerState<Dropdown> {
  List<DropdownMenuEntry> cities = [
    DropdownMenuEntry(
        value: [
          {'lat': 53.865467, 'lng': 10.686559, 'city': 'Lübeck'}
        ],
        label: 'Lübeck',
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18)))),
    DropdownMenuEntry(
        value: [
          {'lat': 54.083336, 'lng': 12.108811, 'city': 'Rostock'}
        ],
        label: 'Rostock',
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18)))),
    DropdownMenuEntry(
        value: [
          {'lat': 53.865467, 'lng': 10.686559, 'city': 'Lübeck'},
          {'lat': 54.083336, 'lng': 12.108811, 'city': 'Rostock'}
        ],
        label: 'Alle Standorte',
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
  ];
  List<DropdownMenuEntry> items2 = [
    DropdownMenuEntry(
        value: 'good',
        label: 'Gute Wasserqualität',
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18)))),
    DropdownMenuEntry(
        value: 'average',
        label: 'Mittlere Wasserqualität',
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18)))),
    DropdownMenuEntry(
        value: 'bad',
        label: 'Schlechte Wasserqualität',
        style: ButtonStyle(
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 18)))),
    DropdownMenuEntry(
        value: 'all',
        label: 'Alle Wasserqualitäten',
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
  ];

  buildDatesDropdownList(List<String> dates) {
    List<DropdownMenuEntry<Object>> datesList = [];
    for (int i = 0; i < dates.length; i++) {
      DateTime date = DateTime.parse(dates[i]);
      datesList.add(DropdownMenuEntry(
          value: dates[i],
          label: '${date.day}.${date.month}.${date.year}',
          style: ButtonStyle(
              textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 18)))));
    }
    datesList.add(DropdownMenuEntry(
        value: 'all',
        label: 'Alle Tage',
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))));
    return datesList;
  }

  List<DropdownMenuEntry> dates = [
    const DropdownMenuEntry(value: 'first day', label: 'first day')
  ];

  InputDecorationTheme dropdownTheme = const InputDecorationTheme(
    filled: true,
    suffixIconColor: Colors.white,
    suffixStyle: TextStyle(color: Colors.white, fontSize: 20),
    fillColor: AppColors.backGroundDark,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelStyle: TextStyle(color: Colors.white, fontSize: 20),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  MenuStyle dropdownStyle = const MenuStyle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu(
          inputDecorationTheme: dropdownTheme,
          trailingIcon: const Icon(Icons.arrow_drop_down, size: 30),
          label: const Text('Ort wählen'),
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
          width: 390,
          dropdownMenuEntries: cities,
          onSelected: (value) {
            if (value is List<Map<String, dynamic>>) {
              ref.read(cityProvider.notifier).state = value;
            }
          },
        ),
        const SizedBox(height: 20),
        DropdownMenu(
            inputDecorationTheme: dropdownTheme,
            trailingIcon: const Icon(Icons.arrow_drop_down, size: 30),
            label: const Text('Wasserqualität wählen'),
            textStyle: const TextStyle(color: Colors.white, fontSize: 20),
            width: 390,
            dropdownMenuEntries: items2,
            onSelected: (value) {
              if (value == 'good') {
                ref.read(qualitiyProvider.notifier).state = 'good';
                ref.read(visibilityProvider.notifier).state = true;
              } else if (value == 'average') {
                ref.read(qualitiyProvider.notifier).state = 'average';
                ref.read(visibilityProvider.notifier).state = true;
              } else if (value == 'bad') {
                ref.read(qualitiyProvider.notifier).state = 'bad';
                ref.read(visibilityProvider.notifier).state = true;
              } else if (value == 'all') {
                ref.read(qualitiyProvider.notifier).state = 'all';
                ref.read(visibilityProvider.notifier).state = true;
              }
            }),
        const SizedBox(height: 20),
        DropdownMenu(
          inputDecorationTheme: dropdownTheme,
          trailingIcon: const Icon(Icons.arrow_drop_down, size: 30),
          label: const Text('Datum wählen'),
          textStyle: const TextStyle(color: Colors.white, fontSize: 20),
          width: 390,
          dropdownMenuEntries: buildDatesDropdownList(ref.watch(dateProvider)),
          onSelected: (value) {
            if (value is String) {
              ref.read(dateSelectedProvider.notifier).state = value;
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
