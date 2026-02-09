import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static DatabaseHelper get instance => _instance;

  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'antilure.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables for scan history
    await db.execute('''
      CREATE TABLE IF NOT EXISTS scan_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT NOT NULL,
        threat_level TEXT NOT NULL,
        risk_score REAL NOT NULL,
        detected_threats TEXT NOT NULL,
        is_safe INTEGER NOT NULL,
        scan_time INTEGER NOT NULL,
        full_data TEXT NOT NULL
      )
    ''');

    // Create table for blacklist
    await db.execute('''
      CREATE TABLE IF NOT EXISTS blacklist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT NOT NULL UNIQUE,
        added_time INTEGER NOT NULL
      )
    ''');

    // Create table for whitelist
    await db.execute('''
      CREATE TABLE IF NOT EXISTS whitelist (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url TEXT NOT NULL UNIQUE,
        added_time INTEGER NOT NULL
      )
    ''');

    // Create table for scam reports
    await db.execute('''
      CREATE TABLE IF NOT EXISTS scam_reports (
        id TEXT PRIMARY KEY,
        report_type TEXT NOT NULL,
        description TEXT NOT NULL,
        url TEXT,
        phone_number TEXT,
        reported_time INTEGER NOT NULL,
        full_data TEXT NOT NULL
      )
    ''');

    // Create table for settings
    await db.execute('''
      CREATE TABLE IF NOT EXISTS settings (
        key TEXT PRIMARY KEY,
        value TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here if needed
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
