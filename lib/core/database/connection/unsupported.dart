import 'package:drift/drift.dart';

QueryExecutor openPlatformSpecificConnection() {
  throw UnsupportedError('No platform specific connection implementation found.');
}
