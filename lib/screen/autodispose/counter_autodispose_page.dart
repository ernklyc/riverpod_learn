import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/state_provider_dispose.dart';

class CounterAutodisposePage extends ConsumerWidget {
  const CounterAutodisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateDisposeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Autodispose Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter: $counter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterStateDisposeProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
