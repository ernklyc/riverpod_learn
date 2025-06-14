import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

//final counterStateDisposeProvider = StateProvider.autoDispose<int>((ref) => 0);
final counterStateDisposeProvider = StateProvider.autoDispose<int>((ref) {
  //ref.keepAlive();
  final cache = ref.keepAlive();
  final timer = Timer.periodic(const Duration(seconds: 10), (timer) => cache.close());
  ref.onDispose(() => timer.cancel());
  return 0;
});