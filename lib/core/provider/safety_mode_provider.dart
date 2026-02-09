import 'package:antilure_mobile_apps/core/models/safety_mode.dart';
import 'package:antilure_mobile_apps/core/services/database_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class SafetyModeNotifier extends StateNotifier<SafetyMode> {
  SafetyModeNotifier() : super(SafetyMode.standard) {
    _loadSafetyMode();
  }

  Future<void> _loadSafetyMode() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query(
        'settings',
        where: 'key = ?',
        whereArgs: ['safety_mode'],
        limit: 1,
      );
      
      int modeIndex = 0;
      if (result.isNotEmpty) {
        final value = result.first['value'] as String;
        modeIndex = int.tryParse(value) ?? 0;
      }
      state = SafetyMode.values[modeIndex];
    } catch (e) {
      state = SafetyMode.standard;
    }
  }

  Future<void> setSafetyMode(SafetyMode mode) async {
    state = mode;
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert(
        'settings',
        {
          'key': 'safety_mode',
          'value': mode.index.toString(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // Handle error silently
    }
  }

  SafetyModeConfig getConfig() {
    return SafetyModeConfig.fromMode(state);
  }
}

final safetyModeProvider =
    StateNotifierProvider<SafetyModeNotifier, SafetyMode>(
      (ref) => SafetyModeNotifier(),
    );
