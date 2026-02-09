import 'dart:convert';
import 'package:antilure_mobile_apps/core/models/scam_report.dart';
import 'package:antilure_mobile_apps/core/services/database_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

class ScamReportNotifier extends StateNotifier<List<ScamReport>> {
  ScamReportNotifier() : super([]) {
    _loadReports();
  }

  Future<void> _loadReports() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final rows = await db.query('scam_reports', orderBy: 'reported_time DESC');
      state = rows
          .map((row) => ScamReport.fromJson(jsonDecode(row['full_data'] as String)))
          .toList();
    } catch (e) {
      state = [];
    }
  }

  Future<void> addReport(ScamReport report) async {
    state = [report, ...state];
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert(
        'scam_reports',
        {
          'id': report.id,
          'report_type': report.category.toString(),
          'description': report.description,
          'url': report.linkOrPhone ?? '',
          'phone_number': report.linkOrPhone ?? '',
          'reported_time': report.dateTime.millisecondsSinceEpoch,
          'full_data': jsonEncode(report.toJson()),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> deleteReport(String id) async {
    state = state.where((report) => report.id != id).toList();
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'scam_reports',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      // Handle error silently
    }
  }

}

final scamReportProvider =
    StateNotifierProvider<ScamReportNotifier, List<ScamReport>>(
  (ref) => ScamReportNotifier(),
);
