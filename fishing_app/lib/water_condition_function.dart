import 'package:flutter_riverpod/flutter_riverpod.dart';

waterCondition(double o2) {
  String waterCondition = '';
  if (o2 >= 145) {
    waterCondition = 'assets/images/freudiger_fisch.png';
  } else if (o2 >= 135 && o2 < 145) {
    waterCondition = 'assets/images/gelber_fisch.png';
  } else {
    waterCondition = 'assets/images/trauriger_fisch.png';
  }
  return waterCondition;
}

final o2Provider = StateProvider<double>((ref) => 0.0);
final visibilityProvider = StateProvider<bool>((ref) => false);
