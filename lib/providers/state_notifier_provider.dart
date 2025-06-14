import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(61);

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

// Global Değişkenler
final counterStateNotifierProvider =
    StateNotifierProvider<CounterStateNotifier, int>(
      (ref) => CounterStateNotifier(),
    );
