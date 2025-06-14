import 'package:flutter_riverpod/flutter_riverpod.dart';

final providerFamily = Provider.family<String, int>((ref, name) {
  return 'Hello ${name * 6}';
});
