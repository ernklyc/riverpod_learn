import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/stream_provider.dart';

class StreamProviderPage extends ConsumerStatefulWidget {
  const StreamProviderPage({super.key});

  @override
  ConsumerState<StreamProviderPage> createState() => _StreamProviderPageState();
}

class _StreamProviderPageState extends ConsumerState<StreamProviderPage> {
  @override
  Widget build(BuildContext context) {
    final counterStream = ref.watch(counterStreamProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Stream Provider Live Counter Page')),
      body: counterStream.when(
        data: (data) {
          return Center(
            child: Text(
              'Live Counter: $data',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
