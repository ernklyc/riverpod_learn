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
