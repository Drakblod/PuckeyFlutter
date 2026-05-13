import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/features/team_builder/providers/lineup_provider.dart';
import 'package:puckey/features/scouting/scouting_screen.dart';

class TeamBuilderScreen extends HookConsumerWidget {
  const TeamBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineupAsync = ref.watch(lineupProvider);
    final tabController = useTabController(initialLength: 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TEAM BUILDER'),
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: PuckeyColors.mint,
          labelColor: PuckeyColors.mint,
          unselectedLabelColor: PuckeyColors.slate,
          tabs: const [
            Tab(text: 'LINE 1'),
            Tab(text: 'LINE 2'),
            Tab(text: 'LINE 3'),
            Tab(text: 'LINE 4'),
            Tab(text: 'GOALIES'),
          ],
        ),
      ),
      body: lineupAsync.when(
        data: (lineup) {
          return TabBarView(
            controller: tabController,
            children: [
              _LineView(lineIndex: 0, lineup: lineup),
              _LineView(lineIndex: 1, lineup: lineup),
              _LineView(lineIndex: 2, lineup: lineup),
              _LineView(lineIndex: 3, lineup: lineup),
              _GoalieView(lineup: lineup),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: PuckeyColors.teal)),
        error: (err, st) => Center(child: Text('Error loading lineup: $err')),
      ),
    );
  }
}

class _LineView extends StatelessWidget {
  final int lineIndex;
  final LineupState lineup;

  const _LineView({required this.lineIndex, required this.lineup});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PuckeyColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: PuckeyColors.surfaceLight, width: 2),
            ),
            child: CustomPaint(painter: RinkPainter()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'LW', player: lineup.getPlayer(lineIndex, 'LW')),
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'C', player: lineup.getPlayer(lineIndex, 'C')),
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'RW', player: lineup.getPlayer(lineIndex, 'RW')),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'LD', player: lineup.getPlayer(lineIndex, 'LD')),
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'RD', player: lineup.getPlayer(lineIndex, 'RD')),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }
}

class _GoalieView extends StatelessWidget {
  final LineupState lineup;

  const _GoalieView({required this.lineup});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: PuckeyColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: PuckeyColors.surfaceLight, width: 2),
            ),
            child: CustomPaint(painter: RinkPainter()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _LineupSlot(lineIndex: 4, slotLabel: 'G1', player: lineup.getPlayer(4, 'G1')),
                  _LineupSlot(lineIndex: 4, slotLabel: 'G2', player: lineup.getPlayer(4, 'G2')),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ],
    );
  }
}

class _LineupSlot extends ConsumerWidget {
  final int lineIndex;
  final String slotLabel;
  final Player? player;

  const _LineupSlot({required this.lineIndex, required this.slotLabel, this.player});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _showSelectionSheet(context, ref),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: PuckeyColors.background.withOpacity(0.8),
              shape: BoxShape.circle,
              border: Border.all(
                color: player != null ? PuckeyColors.mint : PuckeyColors.teal,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: (player != null ? PuckeyColors.mint : PuckeyColors.teal).withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: player != null
                  ? Text(
                      player!.lastName.substring(0, 1),
                      style: const TextStyle(color: PuckeyColors.mint, fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  : const Icon(Icons.add, color: PuckeyColors.teal, size: 30),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: player != null ? PuckeyColors.mint : PuckeyColors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              player != null ? player!.lastName : slotLabel,
              style: const TextStyle(color: PuckeyColors.background, fontWeight: FontWeight.bold, fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectionSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: PuckeyColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: _PlayerSelector(lineIndex: lineIndex, slotLabel: slotLabel),
          ),
        ),
      ),
    );
  }
}

class _PlayerSelector extends HookConsumerWidget {
  final int lineIndex;
  final String slotLabel;

  const _PlayerSelector({required this.lineIndex, required this.slotLabel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(allPlayersProvider);
    final lineupAsync = ref.watch(lineupProvider);
    final searchQuery = useState('');
    final selectedLeague = useState('All');

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SELECT ${slotLabel.startsWith('G') ? 'GOALIE' : 'PLAYER'}',
                style: const TextStyle(color: PuckeyColors.teal, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (lineupAsync.value?.getPlayer(lineIndex, slotLabel) != null)
                TextButton.icon(
                  onPressed: () {
                    ref.read(lineupProvider.notifier).setPlayer(lineIndex, slotLabel, null);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.delete, color: Colors.redAccent, size: 16),
                  label: const Text('REMOVE', style: TextStyle(color: Colors.redAccent)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Search & Filter Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: const TextStyle(color: PuckeyColors.iceBlue),
                  decoration: InputDecoration(
                    hintText: 'Search player...',
                    hintStyle: TextStyle(color: PuckeyColors.slate),
                    prefixIcon: const Icon(Icons.search, color: PuckeyColors.teal),
                    filled: true,
                    fillColor: PuckeyColors.surfaceLight,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) => searchQuery.value = val,
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String>(
                value: selectedLeague.value,
                dropdownColor: PuckeyColors.surface,
                style: const TextStyle(color: PuckeyColors.mint, fontWeight: FontWeight.bold),
                underline: const SizedBox(),
                items: const [
                  DropdownMenuItem(value: 'All', child: Text('All Leagues')),
                  DropdownMenuItem(value: 'SHL', child: Text('SHL')),
                  DropdownMenuItem(value: 'ECHL', child: Text('ECHL')),
                ],
                onChanged: (val) {
                  if (val != null) selectedLeague.value = val;
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: playersAsync.when(
              data: (players) {
                final lineup = lineupAsync.value;
                if (lineup == null) return const SizedBox();

                final filtered = players.where((p) {
                  // Position filter
                  if (slotLabel.startsWith('G') && p.position != 'G') return false;
                  if ((slotLabel == 'LD' || slotLabel == 'RD') && p.position != 'D') return false;
                  if ((slotLabel == 'LW' || slotLabel == 'C' || slotLabel == 'RW') && p.position != 'F') return false;

                  // League filter
                  if (selectedLeague.value != 'All' && p.league != selectedLeague.value) return false;

                  // Search filter
                  if (searchQuery.value.isNotEmpty) {
                    final q = searchQuery.value.toLowerCase();
                    if (!p.fullName.toLowerCase().contains(q) && !p.team.toLowerCase().contains(q)) return false;
                  }

                  return true;
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(child: Text('No players found.', style: TextStyle(color: PuckeyColors.slate)));
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final player = filtered[index];
                    final inLineup = lineup.isPlayerInLineup(player.id);

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(player.fullName, style: TextStyle(color: inLineup ? PuckeyColors.slate : PuckeyColors.iceBlue)),
                      subtitle: Text('${player.team} • ${player.league}', style: TextStyle(color: PuckeyColors.slate)),
                      trailing: inLineup 
                          ? const Icon(Icons.check_circle, color: PuckeyColors.slate)
                          : const Icon(Icons.add_circle_outline, color: PuckeyColors.teal),
                      onTap: inLineup ? null : () {
                        ref.read(lineupProvider.notifier).setPlayer(lineIndex, slotLabel, player);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator(color: PuckeyColors.teal)),
              error: (err, st) => Text('Error: $err'),
            ),
          ),
        ],
      ),
    );
  }
}

class RinkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = PuckeyColors.surfaceLight.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Center line
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);

    // Center circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 4, paint);

    // Crease
    canvas.drawArc(Rect.fromLTWH(size.width / 4, size.height - 40, size.width / 2, 80), 3.14, 3.14, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
