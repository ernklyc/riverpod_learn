import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/models/team_player.dart';

class TeamStateProvider extends StateNotifier<List<TeamPlayer>> {
  final _originalList = [
    TeamPlayer(name: 'Uğurcan Çakır', position: 'Kaleci', avatar: 'https://img.a.transfermarkt.technology/portrait/small/292199-1723802510.jpg?lm=1'),
    TeamPlayer(name: 'Pedro Malheiro', position: 'Sağ Bek', avatar: 'https://img.a.transfermarkt.technology/portrait/small/818252-1723802085.jpg?lm=1'),
    TeamPlayer(name: 'Stefan Savić', position: 'Stoper', avatar: 'https://img.a.transfermarkt.technology/portrait/small/107010-1723802375.jpg?lm=1'),
    TeamPlayer(name: 'Arseniy Batagov', position: 'Stoper', avatar: 'https://img.a.transfermarkt.technology/portrait/small/665048-1724162627.jpg?lm=1'),
    TeamPlayer(name: 'Mustafa Eskihellaç', position: 'Sol Bek', avatar: 'https://img.a.transfermarkt.technology/portrait/small/390379-1725460041.jpg?lm=1'),
    TeamPlayer(name: 'John Lundstram', position: 'Defansif Orta Saha', avatar: 'https://img.a.transfermarkt.technology/portrait/small/156941-1723801542.jpg?lm=1'),
    TeamPlayer(name: 'Okay Yokuşlu', position: 'Merkez Orta Saha', avatar: 'https://img.a.transfermarkt.technology/portrait/small/137616-1723801909.jpg?lm=1'),
    TeamPlayer(name: 'Edin Višća', position: 'Sağ Kanat', avatar: 'https://img.a.transfermarkt.technology/portrait/small/109217-1723801041.jpg?lm=1'),
    TeamPlayer(name: 'Muhammed Cham', position: 'On Numara', avatar: 'https://img.a.transfermarkt.technology/portrait/small/422281-1725013078.jpg?lm=1'),
    TeamPlayer(name: 'Anthony Nwakaeme', position: 'Sol Kanat', avatar: 'https://img.a.transfermarkt.technology/portrait/small/175988-1723800455.jpg?lm=1'),
    TeamPlayer(name: 'Simon Banza', position: 'Santrfor', avatar: 'https://img.a.transfermarkt.technology/portrait/small/344869-1726586877.jpg?lm=1'),
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
                    element.name.toLowerCase().contains(name.toLowerCase()),
              )
              .toList();
    }
  }
}

final teamStateProvider = StateNotifierProvider.autoDispose<
  TeamStateProvider,
  List<TeamPlayer>
>((ref) => TeamStateProvider());
