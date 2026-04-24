import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/features/scouting/scouting_screen.dart';
import 'package:puckey/features/team_builder/team_builder_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    final pages = [
      const ScoutingScreen(),
      const TeamBuilderScreen(),
      const Placeholder(), // Favorites (to be implemented)
    ];

    return Scaffold(
      body: pages[selectedIndex.value],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: PuckeyColors.surfaceLight, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex.value,
          onTap: (index) => selectedIndex.value = index,
          backgroundColor: PuckeyColors.background,
          selectedItemColor: PuckeyColors.teal,
          unselectedItemColor: PuckeyColors.slate,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Scouting',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Team Builder',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'My Scouting',
            ),
          ],
        ),
      ),
    );
  }
}
