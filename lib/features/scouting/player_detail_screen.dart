import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';
import 'package:puckey/core/theme/design_system.dart';

class PlayerDetailScreen extends ConsumerWidget {
  final Player player;

  const PlayerDetailScreen({super.key, required this.player});

  List<double> _calculateAttributes() {
    // Local AI Simulation Math
    double clamp(double val) => val.clamp(30.0, 100.0);
    final gp = max(player.gamesPlayed, 1);

    if (player.position == 'G') {
      return [
        clamp(75 + player.age * 0.2), // Reflexes
        clamp(85 - player.age * 0.3), // Positioning
        clamp(70 + (gp * 0.5)), // Rebounds
        clamp(90 - (player.age * 0.5)), // Agility
        clamp(75 + (gp * 0.3)), // Vision
      ];
    } else {
      final isDef = player.position == 'D';
      final gPerGame = player.goals / gp;
      final aPerGame = player.assists / gp;
      final ptsPerGame = player.points / gp;

      return [
        clamp((gPerGame * 200) + (isDef ? 40 : 50)), // Shooting
        clamp((aPerGame * 150) + (isDef ? 50 : 40)), // Playmaking
        clamp(60 + (player.plusMinus * 1.5) + (isDef ? 20 : 0)), // Defense
        clamp(60 + (ptsPerGame * 25)), // Skating
        clamp(
          50 + (player.penaltyMinutes * 0.5) + (isDef ? 20 : 0),
        ), // Physicality
      ];
    }
  }

  List<String> _getAttributeLabels() {
    if (player.position == 'G') {
      return ['Reflexes', 'Position', 'Rebounds', 'Agility', 'Vision'];
    }
    return ['Shooting', 'Playmaking', 'Defense', 'Skating', 'Physicality'];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, ref),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 32),
                  _buildSpiderChart(),
                  const SizedBox(height: 32),
                  _buildStatsGrid(),
                  const SizedBox(height: 40),
                  _buildActionButtons(context, ref),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
          ),
        ],
      ),
    );
  }

  Widget _buildSpiderChart() {
    final attributes = _calculateAttributes();
    final labels = _getAttributeLabels();
    final color = player.position == 'G'
        ? Colors.purpleAccent
        : (player.position == 'D' ? PuckeyColors.teal : PuckeyColors.mint);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI SCOUTING REPORT',
          style: TextStyle(
            color: PuckeyColors.slate,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: PuckeyColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: PuckeyColors.surfaceLight),
          ),
          child: RadarChart(
            RadarChartData(
              dataSets: [
                RadarDataSet(
                  fillColor: color.withOpacity(0.2),
                  borderColor: color,
                  entryRadius: 4,
                  dataEntries: attributes
                      .map((val) => RadarEntry(value: val))
                      .toList(),
                  borderWidth: 2,
                ),
              ],
              radarBackgroundColor: Colors.transparent,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(
                color: PuckeyColors.surfaceLight,
                width: 1,
              ),
              tickCount: 5,
              ticksTextStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 10,
              ),
              tickBorderData: const BorderSide(
                color: PuckeyColors.surfaceLight,
                width: 1,
              ),
              gridBorderData: const BorderSide(
                color: PuckeyColors.surfaceLight,
                width: 1,
              ),
              getTitle: (index, angle) {
                return RadarChartTitle(
                  text: labels[index],
                  angle: angle,
                  positionPercentageOffset: 0.1,
                );
              },
              titleTextStyle: const TextStyle(
                color: PuckeyColors.iceBlue,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: const Duration(milliseconds: 400),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [PuckeyColors.surfaceLight, PuckeyColors.background],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 120,
                  color: PuckeyColors.teal.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      PuckeyColors.background,
                      PuckeyColors.background.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: PuckeyColors.teal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                player.position,
                style: const TextStyle(
                  color: PuckeyColors.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              player.league,
              style: const TextStyle(
                color: PuckeyColors.slate,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          player.fullName,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: PuckeyColors.iceBlue,
          ),
        ),
        Text(
          player.team,
          style: const TextStyle(fontSize: 20, color: PuckeyColors.teal),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SEASON STATISTICS',
          style: TextStyle(
            color: PuckeyColors.slate,
            letterSpacing: 1.2,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _StatItem(label: 'GAMES', value: player.gamesPlayed.toString()),
            if (player.position != 'G') ...[
              _StatItem(label: 'GOALS', value: player.goals.toString()),
              _StatItem(label: 'ASSISTS', value: player.assists.toString()),
              _StatItem(
                label: 'POINTS',
                value: player.points.toString(),
                highlight: true,
              ),
              _StatItem(
                label: '+ / -',
                value: player.plusMinus > 0
                    ? '+${player.plusMinus}'
                    : player.plusMinus.toString(),
              ),
            ] else ...[
              _StatItem(
                label: 'AGE',
                value: player.age.toString(),
                highlight: true,
              ),
            ],
            _StatItem(label: 'PIM', value: player.penaltyMinutes.toString()),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: PuckeyColors.teal,
            foregroundColor: PuckeyColors.background,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'ADD TO LINEUP',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            ref.read(storageServiceProvider).toggleFavorite(player);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: PuckeyColors.iceBlue,
            side: const BorderSide(color: PuckeyColors.surfaceLight),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                player.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: player.isFavorite
                    ? PuckeyColors.error
                    : PuckeyColors.slate,
              ),
              const SizedBox(width: 8),
              const Text('SAVE TO MY SCOUTING'),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _StatItem({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PuckeyColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight
              ? PuckeyColors.teal.withOpacity(0.3)
              : PuckeyColors.surfaceLight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: highlight ? PuckeyColors.mint : PuckeyColors.iceBlue,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: PuckeyColors.slate),
          ),
        ],
      ),
    );
  }
}
