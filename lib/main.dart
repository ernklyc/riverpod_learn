import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/thema_change_provider.dart';
import 'package:riverpod_learn/routes/app_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChange = ref.watch(themeChangeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Demo',
      theme: themeChange ? ThemeData.light() : ThemeData.dark(),
      routerConfig: appRouter,
    );
  }
}