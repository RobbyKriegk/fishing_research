import 'dart:math';

class GeoUtils {
  static double haversine(double lat1, double lon1, double lat2, double lon2) {
    // Radius der Erde in km
    const double R = 6371.0;

    // Umrechnung der Breiten- und Längengrade von Grad in Radian
    lat1 = _degreesToRadians(lat1);
    lon1 = _degreesToRadians(lon1);
    lat2 = _degreesToRadians(lat2);
    lon2 = _degreesToRadians(lon2);

    // Deltas der Breiten- und Längengrade
    double dlat = lat2 - lat1;
    double dlon = lon2 - lon1;

    // Haversine-Formel
    double a =
        pow(sin(dlat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dlon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Entfernung in km
    double distance = R * c * 1000;

    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}
