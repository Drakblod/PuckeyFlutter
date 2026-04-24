import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/features/team_builder/providers/lineup_provider.dart';
import 'package:puckey/features/scouting/scouting_screen.dart';

class TeamBuilderScreen extends ConsumerWidget {
  const TeamBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineup = ref.watch(lineupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TEAM BUILDER'),
        actions: [
          if (lineup.goalie != null || lineup.center != null)
            IconButton(
              icon: const Icon(Icons.share, color: PuckeyColors.teal),
              onPressed: () {},
            ),
        ],
      ),
      body: Stack(
        children: [
          // Rink Background
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: PuckeyColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: PuckeyColors.surfaceLight, width: 2),
              ),
              child: CustomPaint(
                painter: RinkPainter(),
              ),
            ),
          ),
          // Slots
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Forwards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _LineupSlot(label: 'LW', player: lineup.leftWing),
                    _LineupSlot(label: 'C', player: lineup.center),
                    _LineupSlot(label: 'RW', player: lineup.rightWing),
                  ],
                ),
                const Spacer(),
                // Defense
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _LineupSlot(label: 'LD', player: lineup.leftDefense),
                    _LineupSlot(label: 'RD', player: lineup.rightDefense),
                  ],
                ),
                const Spacer(),
                // Goalie
                _LineupSlot(label: 'G', player: lineup.goalie),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LineupSlot extends ConsumerWidget {
  final String label;
  final Player? player;

  const _LineupSlot({required this.label, this.player});

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
              color: PuckeyColors.background.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              border: Border.all(
                color: player != null ? PuckeyColors.mint : PuckeyColors.teal,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: (player != null ? PuckeyColors.mint : PuckeyColors.teal).withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: player != null
                  ? Text(
                      player!.lastName.substring(0, 1),
                      style: const TextStyle(
                        color: PuckeyColors.mint,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
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
              player != null ? player!.lastName : label,
              style: const TextStyle(
                color: PuckeyColors.background,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
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
      backgroundColor: PuckeyColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _PlayerSelector(slot: label),
    );
  }
}

class _PlayerSelector extends ConsumerWidget {
  final String slot;

  const _PlayerSelector({required this.slot});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playersAsync = ref.watch(playersProvider);

    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SELECT ${slot == 'G' ? 'GOALIE' : 'PLAYER'}',
            style: const TextStyle(
              color: PuckeyColors.teal,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: playersAsync.when(
              data: (players) {
                // Filter by position (simplified)
                final filtered = players.where((p) {
                  if (slot == 'G') return p.position == 'G';
                  if (slot == 'LD' || slot == 'RD') return p.position == 'D';
                  return p.position == 'F';
                }).toList();

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final player = filtered[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(player.fullName, style: const TextStyle(color: PuckeyColors.iceBlue)),
                      subtitle: Text(player.team, style: const TextStyle(color: PuckeyColors.slate)),
                      trailing: const Icon(Icons.add_circle_outline, color: PuckeyColors.teal),
                      onTap: () {
                        ref.read(lineupProvider.notifier).setPlayer(slot, player);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
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
      ..color = PuckeyColors.surfaceLight.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 4,
      paint,
    );

    // Crease
    canvas.drawArc(
      Rect.fromLTWH(size.width / 4, size.height - 40, size.width / 2, 80),
      3.14,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
