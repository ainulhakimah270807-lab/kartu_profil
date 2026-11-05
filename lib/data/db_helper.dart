import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // Constructor private
  DbHelper._({String? pathOverride})
      : _pathOverride = pathOverride;

  // Instance utama database
  static final DbHelper instance = DbHelper._();

  // Database sementara untuk pengujian
  factory DbHelper.inMemory() {
    return DbHelper._(
      pathOverride: inMemoryDatabasePath,
    );
  }

  // Konfigurasi database
  static const String _dbName = 'kartu_profil.db';
  static const int _dbVersion = 2;

  static const String tableProjects = 'projects';

  final String? _pathOverride;

  Database? _db;

  // Mengambil database
  Future<Database> get database async {
    if (_db != null && _db!.isOpen) {
      return _db!;
    }

    _db = await _open();
    return _db!;
  }

  // Membuka database
  Future<Database> _open() async {
    final path = _pathOverride ??
        join(
          await getDatabasesPath(),
          _dbName,
        );

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Membuat tabel pertama kali
  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
      CREATE TABLE $tableProjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        tech_stack TEXT NOT NULL,
        created_at TEXT NOT NULL,
        is_favorite INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // Migrasi database
  Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE $tableProjects
        ADD COLUMN is_favorite INTEGER NOT NULL DEFAULT 0
      ''');
    }
  }

  // Menutup database
  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}