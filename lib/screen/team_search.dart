import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/providers/team_provider.dart';

class TeamSearch extends ConsumerWidget {
  const TeamSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamStateList = ref.watch(teamStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Search'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) =>
                ref.read(teamStateProvider.notifier).filteredPlayer(value),
            decoration: const InputDecoration(
              hintText: 'Search for a player',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: teamStateList.length,
              itemBuilder: (context, index) {
                final player = teamStateList[index];
                return ListTile(
                  title: Text(player['name']!.toString()),
                  subtitle: Text(player['position']!.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}