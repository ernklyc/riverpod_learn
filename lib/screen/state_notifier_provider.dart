import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/state_notifier_provider.dart';

class StateNotifierProviderPage extends ConsumerWidget {
  const StateNotifierProviderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterStateNotifier = ref.watch(counterStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('State Notifier Provider')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $counterStateNotifier',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(onPressed: () {
            ref.read(counterStateNotifierProvider.notifier).increment();
          }, child: Icon(Icons.add)),
          FloatingActionButton(onPressed: () {
            ref.read(counterStateNotifierProvider.notifier).reset();
          }, child: Icon(Icons.refresh)),
          FloatingActionButton(onPressed: () {
            ref.read(counterStateNotifierProvider.notifier).decrement();
          }, child: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
