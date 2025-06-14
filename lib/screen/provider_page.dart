import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/simple_providers.dart';

class ProvidersPage extends ConsumerWidget {
  const ProvidersPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textPrpvider = ref.watch(simpleProvider);
    final atackOnTitanText = ref.watch(atackOnTitan);
    final yearText = ref.watch(yearProvider);
    final appBarTitleText = ref.watch(appBarTitle);

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitleText),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$textPrpvider $atackOnTitanText $yearText'),
          ],
        ),
      )
    );
  }
}