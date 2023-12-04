import 'package:flutter_riverpod/flutter_riverpod.dart';

waterCondition(double o2) {
  String waterCondition = '';
  if (o2 >= 145) {
    waterCondition = 'assets/images/happy_green_fish.png';
  } else if (o2 >= 140 && o2 < 145) {
    waterCondition = 'assets/images/yellow_fish.png';
  } else {
    waterCondition = 'assets/images/sad_red_fish.png';
  }
  return waterCondition;
}

final o2Provider = StateProvider<double>((ref) => 0.0);
final visibilityProvider = StateProvider<bool>((ref) => false);
