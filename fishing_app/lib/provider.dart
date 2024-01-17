import 'package:flutter_riverpod/flutter_riverpod.dart';

final qualitiyProvider = StateProvider<String>((ref) => '');
final o2Provider = StateProvider<double>((ref) => 0.0);
final visibilityProvider = StateProvider<bool>((ref) => false);
final dateProvider = StateProvider<List<String>>((ref) => []);
final dateSelectedProvider = StateProvider<String>((ref) => '');
final zoomProvider = StateProvider<double>((ref) => 10.0);
