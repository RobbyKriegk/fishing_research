waterCondition(double o2) {
  String waterCondition = '';
  if (o2 >= 155) {
    waterCondition = 'assets/images/happy_green_fish.png';
  } else if (o2 >= 140 && o2 < 155) {
    waterCondition = 'assets/images/yellow_fish.png';
  } else {
    waterCondition = 'assets/images/sad_red_fish.png';
  }
  return waterCondition;
}
