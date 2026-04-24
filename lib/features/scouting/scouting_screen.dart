import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/features/scouting/player_detail_screen.dart';

final playersProvider = StateNotifierProvider<PlayersNotifier, AsyncValue<List<Player>>>((ref) {
  final storage = ref.watch(storageServiceProvider);
  return PlayersNotifier(storage);
});

class PlayersNotifier extends StateNotifier<AsyncValue<List<Player>>> {
  final StorageService _storage;
  PlayersNotifier(this._storage) : super(const AsyncValue.loading()) {
    loadPlayers();
  }

  Future<void> loadPlayers() async {
    state = const AsyncValue.loading();
    try {
      final players = await _storage.getAllPlayers();
      state = AsyncValue.data(players);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      loadPlayers();
      return;
    }
    state = const AsyncValue.loading();
    try {
      final players = await _storage.searchPlayers(query);
      state = AsyncValue.data(players);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

class ScoutingScreen extends HookConsumerWidget {
  const ScoutingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(playersProvider);
    final searchController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PUCKEY SCOUTING'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: PuckeyColors.teal),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                ref.read(playersProvider.notifier).search(value);
              },
              decoration: InputDecoration(
                hintText: 'Search for players...',
                prefixIcon: const Icon(Icons.search, color: PuckeyColors.teal),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: PuckeyColors.slate),
                        onPressed: () {
                          searchController.clear();
                          ref.read(playersProvider.notifier).search('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: PuckeyColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(color: PuckeyColors.slate),
              ),
              style: const TextStyle(color: PuckeyColors.iceBlue),
            ),
          ),
          Expanded(
            child: playersAsync.when(
              data: (players) => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerDetailScreen(player: player),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'player_${player.id}',
                      child: _PlayerListItem(player: player),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerListItem extends StatelessWidget {
  final Player player;

  const _PlayerListItem({required this.player});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: PuckeyColors.surfaceLight,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  player.position,
                  style: const TextStyle(
                    color: PuckeyColors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.fullName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PuckeyColors.iceBlue,
                    ),
                  ),
                  Text(
                    '${player.team} | ${player.league}',
                    style: const TextStyle(color: PuckeyColors.slate),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${player.points} PTS',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PuckeyColors.mint,
                  ),
                ),
                Text(
                  '${player.goals}G / ${player.assists}A',
                  style: const TextStyle(fontSize: 12, color: PuckeyColors.slate),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
