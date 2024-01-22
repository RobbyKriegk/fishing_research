import 'package:fishing_app/app_colors.dart';
import 'package:fishing_app/startpage/dropdown.dart';
import 'package:flutter/material.dart';

import '../database_connection.dart';
import '../map_prototype/map_prototype.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    csvFromServer();
    //fetchData();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('IOW - Visualisierung Wasserqualität',
              style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: AppColors.backGroundDark,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          color: AppColors.backGroundLight,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  constraints:
                      const BoxConstraints(minHeight: 400, maxHeight: 500),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5)),
                  child: const MapPrototype(),
                ),
                const SizedBox(height: 20),
                const Dropdown()
              ])),
    );
  }
}
