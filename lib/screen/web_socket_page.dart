import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/web_socket_provider.dart';

class WebSocketPage extends ConsumerWidget {
  const WebSocketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webSocketStream = ref.watch(webSocketProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket')),
      body: Center(
        child: webSocketStream.when(
          data:
              (data) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BTC/USDT Price',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Text(data, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
