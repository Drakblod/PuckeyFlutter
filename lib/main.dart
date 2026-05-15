import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:puckey/firebase_options.dart';
import 'package:puckey/core/database/app_database.dart';
import 'package:puckey/core/services/storage_service.dart';
import 'package:puckey/core/theme/design_system.dart';
import 'package:puckey/features/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  final db = AppDatabase();
  final storageService = StorageService(db);
  
  try {
    // Pre-load players from JSON and seed DB
    await storageService.initialize().timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint('Storage initialization warning: $e');
  }

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: const PuckeyApp(),
    ),
  );
}

class PuckeyApp extends StatelessWidget {
  const PuckeyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puckey',
      debugShowCheckedModeBanner: false,
      theme: PuckeyTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
