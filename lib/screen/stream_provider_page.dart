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

// Map ile yapılan kod
/*
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamStateProvider extends StateNotifier<List<Map<String, String>>> {
  final _originalList = [
    {'name': 'Uğurcan Çakır', 'position': 'Kaleci'},
    {'name': 'Pedro Malheiro', 'position': 'Sağ Bek'},
    {'name': 'Stefan Savić', 'position': 'Stoper'},
    {'name': 'Arseniy Batagov', 'position': 'Stoper'},
    {'name': 'Mustafa Eskihellaç', 'position': 'Sol Bek'},
    {'name': 'John Lundstram', 'position': 'Defansif Orta Saha'},
    {'name': 'Okay Yokuşlu', 'position': 'Merkez Orta Saha'},
    {'name': 'Edin Višća', 'position': 'Sağ Kanat'},
    {'name': 'Muhammed Cham', 'position': 'On Numara'},
    {'name': 'Anthony Nwakaeme', 'position': 'Sol Kanat'},
    {'name': 'Simon Banza', 'position': 'Santrfor'},
  ];

  TeamStateProvider() : super([]) {
    state = _originalList;
  }

  void filteredPlayer(String name) {
    if (name.isEmpty) {
      state = _originalList;
    } else {
      state =
          _originalList
              .where(
                (element) =>
                    element['name']!.toLowerCase().contains(name.toLowerCase()),
              )
              .toList();
    }
  }
}

final teamStateProvider = StateNotifierProvider.autoDispose<
  TeamStateProvider,
  List<Map<String, String>>
>((ref) => TeamStateProvider());
*/