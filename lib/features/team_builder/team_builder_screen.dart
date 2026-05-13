import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/core/services/storage_service.dart';
import 'package:puckey/features/team_builder/providers/lineup_provider.dart';
import 'package:puckey/features/scouting/scouting_screen.dart';

class TeamBuilderScreen extends HookConsumerWidget {
  const TeamBuilderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineupAsync = ref.watch(lineupProvider);
    final teamsAsync = ref.watch(teamsProvider);
    final selectedTeamId = ref.watch(selectedTeamIdProvider);
    final tabController = useTabController(initialLength: 7);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('TEAM BUILDER'),
            const SizedBox(width: 12),
            teamsAsync.when(
              data: (teams) {
                final currentTeam = teams.firstWhere((t) => t.id == selectedTeamId, orElse: () => teams.first);
                return PopupMenuButton<int>(
                  initialValue: selectedTeamId,
                  onSelected: (id) {
                    if (id == -1) {
                      _showCreateTeamDialog(context, ref);
                    } else {
                      ref.read(selectedTeamIdProvider.notifier).state = id;
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: PuckeyColors.surfaceLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentTeam.name.toUpperCase(),
                          style: const TextStyle(color: PuckeyColors.mint, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const Icon(Icons.arrow_drop_down, color: PuckeyColors.mint, size: 20),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => [
                    ...teams.map((t) => PopupMenuItem(
                      value: t.id,
                      child: Text(t.name, style: const TextStyle(color: PuckeyColors.iceBlue)),
                    )),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: -1,
                      child: Row(
                        children: [
                          Icon(Icons.add, color: PuckeyColors.mint, size: 18),
                          SizedBox(width: 8),
                          Text('NEW TEAM', style: TextStyle(color: PuckeyColors.mint)),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),
          ],
        ),
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
            Tab(text: 'POWER PLAY'),
            Tab(text: 'BOXPLAY'),
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
              _PowerPlayView(lineup: lineup),
              _BoxplayView(lineup: lineup),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: PuckeyColors.teal)),
        error: (err, st) => Center(child: Text('Error loading lineup: $err')),
      ),
    );
  }

  void _showCreateTeamDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: PuckeyColors.surface,
        title: const Text('CREATE NEW TEAM', style: TextStyle(color: PuckeyColors.mint)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: PuckeyColors.iceBlue),
          decoration: const InputDecoration(
            hintText: 'Team Name (e.g. Leksands IF 26/27)',
            hintStyle: TextStyle(color: PuckeyColors.slate),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: PuckeyColors.teal)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: PuckeyColors.slate)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: PuckeyColors.mint),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                final id = await ref.read(storageServiceProvider).createTeam(controller.text);
                ref.invalidate(teamsProvider);
                ref.read(selectedTeamIdProvider.notifier).state = id;
                Navigator.pop(context);
              }
            },
            child: const Text('CREATE', style: TextStyle(color: PuckeyColors.background)),
          ),
        ],
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
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'LW', player: lineup.getPlayer(lineIndex, 'LW'), tag: lineup.getTag(lineIndex, 'LW')),
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'C', player: lineup.getPlayer(lineIndex, 'C'), tag: lineup.getTag(lineIndex, 'C')),
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'RW', player: lineup.getPlayer(lineIndex, 'RW'), tag: lineup.getTag(lineIndex, 'RW')),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'LD', player: lineup.getPlayer(lineIndex, 'LD'), tag: lineup.getTag(lineIndex, 'LD')),
                  _LineupSlot(lineIndex: lineIndex, slotLabel: 'RD', player: lineup.getPlayer(lineIndex, 'RD'), tag: lineup.getTag(lineIndex, 'RD')),
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

class _PowerPlayView extends StatelessWidget {
  final LineupState lineup;

  const _PowerPlayView({required this.lineup});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _UnitHeader(title: 'PP UNIT 1'),
        _SpecialUnitRow(lineIndex: 5, slots: ['F1', 'F2', 'F3', 'D1', 'D2'], lineup: lineup),
        const SizedBox(height: 32),
        _UnitHeader(title: 'PP UNIT 2'),
        _SpecialUnitRow(lineIndex: 6, slots: ['F1', 'F2', 'F3', 'D1', 'D2'], lineup: lineup),
      ],
    );
  }
}

class _BoxplayView extends StatelessWidget {
  final LineupState lineup;

  const _BoxplayView({required this.lineup});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _UnitHeader(title: 'PK UNIT 1'),
        _SpecialUnitRow(lineIndex: 7, slots: ['F1', 'F2', 'D1', 'D2'], lineup: lineup),
        const SizedBox(height: 32),
        _UnitHeader(title: 'PK UNIT 2'),
        _SpecialUnitRow(lineIndex: 8, slots: ['F1', 'F2', 'D1', 'D2'], lineup: lineup),
      ],
    );
  }
}

class _UnitHeader extends StatelessWidget {
  final String title;
  const _UnitHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(color: PuckeyColors.mint, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
  }
}

class _SpecialUnitRow extends StatelessWidget {
  final int lineIndex;
  final List<String> slots;
  final LineupState lineup;

  const _SpecialUnitRow({required this.lineIndex, required this.slots, required this.lineup});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PuckeyColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuckeyColors.surfaceLight),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 16,
        alignment: WrapAlignment.center,
        children: slots.map((s) => _LineupSlot(
          lineIndex: lineIndex,
          slotLabel: s,
          player: lineup.getPlayer(lineIndex, s),
          tag: lineup.getTag(lineIndex, s),
          small: true,
        )).toList(),
      ),
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
                  _LineupSlot(lineIndex: 4, slotLabel: 'G1', player: lineup.getPlayer(4, 'G1'), tag: lineup.getTag(4, 'G1')),
                  _LineupSlot(lineIndex: 4, slotLabel: 'G2', player: lineup.getPlayer(4, 'G2'), tag: lineup.getTag(4, 'G2')),
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
  final String? tag;
  final bool small;

  const _LineupSlot({required this.lineIndex, required this.slotLabel, this.player, this.tag, this.small = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = small ? 60.0 : 75.0;
    final fontSize = small ? 24.0 : 30.0;
    final tagSize = small ? 7.0 : 8.0;

    return GestureDetector(
      onLongPress: player != null ? () => _showTagPicker(context, ref) : null,
      onTap: () => _showSelectionSheet(context, ref),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: size,
                height: size,
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
                          style: TextStyle(color: PuckeyColors.mint, fontSize: fontSize, fontWeight: FontWeight.bold),
                        )
                      : Icon(Icons.add, color: PuckeyColors.teal, size: small ? 24 : 30),
                ),
              ),
              if (tag != null)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: PuckeyColors.iceBlue,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: PuckeyColors.background, width: 1),
                    ),
                    child: Text(
                      tag!.toUpperCase(),
                      style: TextStyle(color: PuckeyColors.background, fontSize: tagSize, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: size + 10,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: player != null ? PuckeyColors.mint : PuckeyColors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              player != null ? player!.lastName : slotLabel,
              textAlign: TextAlign.center,
              style: const TextStyle(color: PuckeyColors.background, fontWeight: FontWeight.bold, fontSize: 10),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showTagPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: PuckeyColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ASSIGN ROLE', style: TextStyle(color: PuckeyColors.mint, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                'Sniper', 'Playmaker', 'Speedster', 'Power Forward', 'Two-Way', 'Grinder', 'Enforcer', 'Offensive D', 'Shut Down D'
              ].map((t) => ActionChip(
                backgroundColor: tag == t ? PuckeyColors.mint : PuckeyColors.surfaceLight,
                label: Text(t, style: TextStyle(color: tag == t ? PuckeyColors.background : PuckeyColors.iceBlue)),
                onPressed: () {
                  ref.read(lineupProvider.notifier).updateTag(lineIndex, slotLabel, t == tag ? null : t);
                  Navigator.pop(context);
                },
              )).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
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
                  DropdownMenuItem(value: 'HockeyAllsvenskan', child: Text('HA')),
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
                  if ((slotLabel == 'LW' || slotLabel == 'C' || slotLabel == 'RW' || slotLabel.startsWith('F')) && p.position != 'F') {
                     // Check for general 'F' slot in special teams
                     if (slotLabel.startsWith('F') && p.position == 'F') return true;
                     return false;
                  }
                  if (slotLabel.startsWith('D') && p.position != 'D' && p.position != 'G') {
                    // Special teams D slots
                    if (p.position == 'D') return true;
                    return false;
                  }

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
