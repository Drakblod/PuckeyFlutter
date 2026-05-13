import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/features/scouting/player_detail_screen.dart';

class ScoutingFilterState {
  final String query;
  final String league; // 'All', 'SHL', 'ECHL'
  final String position; // 'All', 'F', 'D', 'G'
  final String sortBy; // 'Points', 'Goals', 'Assists', 'Age', 'PlusMinus'

  ScoutingFilterState({
    this.query = '',
    this.league = 'All',
    this.position = 'All',
    this.sortBy = 'Points',
  });

  ScoutingFilterState copyWith({
    String? query,
    String? league,
    String? position,
    String? sortBy,
  }) {
    return ScoutingFilterState(
      query: query ?? this.query,
      league: league ?? this.league,
      position: position ?? this.position,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

final allPlayersProvider = FutureProvider<List<Player>>((ref) async {
  final storage = ref.watch(storageServiceProvider);
  return storage.getAllPlayers();
});

final scoutingFilterProvider = StateProvider<ScoutingFilterState>(
  (ref) => ScoutingFilterState(),
);

final filteredPlayersProvider = Provider<AsyncValue<List<Player>>>((ref) {
  final playersAsync = ref.watch(allPlayersProvider);
  final filter = ref.watch(scoutingFilterProvider);

  return playersAsync.whenData((players) {
    var filtered = players.where((p) {
      if (filter.league != 'All' && p.league != filter.league) return false;
      if (filter.position != 'All' && p.position != filter.position)
        return false;
      if (filter.query.isNotEmpty) {
        final queryLower = filter.query.toLowerCase();
        if (!p.firstName.toLowerCase().contains(queryLower) &&
            !p.lastName.toLowerCase().contains(queryLower) &&
            !p.team.toLowerCase().contains(queryLower)) {
          return false;
        }
      }
      return true;
    }).toList();

    filtered.sort((a, b) {
      switch (filter.sortBy) {
        case 'Goals':
          return b.goals.compareTo(a.goals);
        case 'Assists':
          return b.assists.compareTo(a.assists);
        case 'PlusMinus':
          return b.plusMinus.compareTo(a.plusMinus);
        case 'Age':
          return a.age.compareTo(b.age); // Younger first
        case 'Points':
        default:
          return b.points.compareTo(a.points);
      }
    });

    return filtered;
  });
});

class ScoutingScreen extends HookConsumerWidget {
  const ScoutingScreen({super.key});

  void _showFilterSheet(BuildContext context, WidgetRef ref) {
    final filter = ref.read(scoutingFilterProvider);
    showModalBottomSheet(
      context: context,
      backgroundColor: PuckeyColors.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sort By',
                  style: TextStyle(
                    color: PuckeyColors.iceBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['Points', 'Goals', 'Assists', 'PlusMinus', 'Age']
                      .map((sort) {
                        return ChoiceChip(
                          label: Text(sort),
                          selected: filter.sortBy == sort,
                          onSelected: (selected) {
                            if (selected) {
                              ref
                                  .read(scoutingFilterProvider.notifier)
                                  .update(
                                    (state) => state.copyWith(sortBy: sort),
                                  );
                              Navigator.pop(context);
                            }
                          },
                          selectedColor: PuckeyColors.teal,
                          backgroundColor: PuckeyColors.surface,
                          labelStyle: TextStyle(
                            color: filter.sortBy == sort
                                ? PuckeyColors.surface
                                : PuckeyColors.slate,
                          ),
                        );
                      })
                      .toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  'League',
                  style: TextStyle(
                    color: PuckeyColors.iceBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: ['All', 'SHL', 'ECHL'].map((league) {
                    return ChoiceChip(
                      label: Text(league),
                      selected: filter.league == league,
                      onSelected: (selected) {
                        if (selected) {
                          ref
                              .read(scoutingFilterProvider.notifier)
                              .update(
                                (state) => state.copyWith(league: league),
                              );
                        }
                      },
                      selectedColor: PuckeyColors.teal,
                      backgroundColor: PuckeyColors.surface,
                      labelStyle: TextStyle(
                        color: filter.league == league
                            ? PuckeyColors.surface
                            : PuckeyColors.slate,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(filteredPlayersProvider);
    final filter = ref.watch(scoutingFilterProvider);
    final searchController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('PUCKEY SCOUTING'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: PuckeyColors.teal),
            onPressed: () => _showFilterSheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                ref
                    .read(scoutingFilterProvider.notifier)
                    .update((state) => state.copyWith(query: value));
              },
              decoration: InputDecoration(
                hintText: 'Search for players...',
                prefixIcon: const Icon(Icons.search, color: PuckeyColors.teal),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: PuckeyColors.slate,
                        ),
                        onPressed: () {
                          searchController.clear();
                          ref
                              .read(scoutingFilterProvider.notifier)
                              .update((state) => state.copyWith(query: ''));
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _buildQuickFilter(
                  ref,
                  filter.position,
                  'All',
                  'All Positions',
                  true,
                ),
                _buildQuickFilter(ref, filter.position, 'F', 'Forwards', true),
                _buildQuickFilter(
                  ref,
                  filter.position,
                  'D',
                  'Defensemen',
                  true,
                ),
                _buildQuickFilter(ref, filter.position, 'G', 'Goalies', true),
              ],
            ),
          ),
          Expanded(
            child: playersAsync.when(
              data: (players) => ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final player = players[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlayerDetailScreen(player: player),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'player_${player.id}',
                      child: _PlayerListItem(
                        player: player,
                        rank: index + 1,
                        filter: filter,
                      ),
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

  Widget _buildQuickFilter(
    WidgetRef ref,
    String currentPos,
    String value,
    String label,
    bool isPosition,
  ) {
    final isSelected = currentPos == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            ref
                .read(scoutingFilterProvider.notifier)
                .update((state) => state.copyWith(position: value));
          }
        },
        selectedColor: PuckeyColors.teal.withOpacity(0.2),
        backgroundColor: PuckeyColors.surface,
        side: BorderSide(
          color: isSelected ? PuckeyColors.teal : PuckeyColors.surfaceLight,
        ),
        labelStyle: TextStyle(
          color: isSelected ? PuckeyColors.teal : PuckeyColors.slate,
        ),
      ),
    );
  }
}

class _PlayerListItem extends StatelessWidget {
  final Player player;
  final int rank;
  final ScoutingFilterState filter;

  const _PlayerListItem({
    required this.player,
    required this.rank,
    required this.filter,
  });

  Color _getPositionColor() {
    switch (player.position) {
      case 'F':
        return PuckeyColors.mint;
      case 'D':
        return PuckeyColors.teal;
      case 'G':
        return Colors.purpleAccent;
      default:
        return PuckeyColors.slate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final posColor = _getPositionColor();
    final isGoalie = player.position == 'G';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 30,
              alignment: Alignment.center,
              child: Text(
                '#$rank',
                style: const TextStyle(
                  color: PuckeyColors.slate,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: posColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: posColor.withOpacity(0.3)),
              ),
              child: Center(
                child: Text(
                  player.position,
                  style: TextStyle(
                    color: posColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: PuckeyColors.surfaceLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          player.league,
                          style: const TextStyle(
                            color: PuckeyColors.slate,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        player.team,
                        style: const TextStyle(
                          color: PuckeyColors.slate,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (filter.sortBy == 'Age')
                  Text(
                    '${player.age} yrs',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PuckeyColors.mint,
                    ),
                  )
                else if (isGoalie)
                  Text(
                    '${player.gamesPlayed} GP',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: PuckeyColors.mint,
                    ),
                  )
                else ...[
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: PuckeyColors.slate,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
