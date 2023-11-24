import 'package:flutter_riverpod/flutter_riverpod.dart';

waterCondition(double temp) {
  String waterCondition = '';
  if (temp >= 5 && temp <= 15) {
    waterCondition = 'assets/images/freudiger_fisch.png';
  } else if (temp >= 15 && temp <= 25) {
    waterCondition = 'assets/images/gelber_fisch.png';
  } else {
    waterCondition = 'assets/images/trauriger_fisch.png';
  }
  return waterCondition;
}

final tempProvider = StateProvider<double>((ref) => 0.0);
final visibilityProvider = StateProvider<bool>((ref) => false);
