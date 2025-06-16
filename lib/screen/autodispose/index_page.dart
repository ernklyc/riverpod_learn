import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_learn/providers/thema_change_provider.dart';

class IndexPage extends ConsumerWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChange = ref.watch(themeChangeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Index Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              ElevatedButton(
                onPressed: () {
                  context.push('/counter');
                },
                child: const Text('Counter Page'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/team_search');
                },
                child: const Text('Team Search Page'),
              ),
            Switch(
              value: themeChange,
              onChanged:
                  (newValue) =>
                      ref.read(themeChangeProvider.notifier).state = newValue,
            ),
          ],
        ),
      ),
    );
  }
}
