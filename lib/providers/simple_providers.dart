import 'package:flutter_riverpod/flutter_riverpod.dart';

final simpleProvider = Provider<String>((ref) {
  return 'Hello, Provider!';
});

final atackOnTitan = Provider<String>((ref) => 'Attack on Titan');

final yearProvider = Provider<int>((ref) => 2025);

final appBarTitle = Provider<String>((ref) => 'Providers Learning');