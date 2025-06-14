import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/provider_family.dart';

class ProviderFamilyPage extends ConsumerWidget {
  const ProviderFamilyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(providerFamily(30));
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Family')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Provider Family: $value'),
          ],
        ),
      ),
    );
  }
}