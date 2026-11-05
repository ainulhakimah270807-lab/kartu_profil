import 'package:sqflite/sqflite.dart';

import '../models/project.dart';
import 'db_helper.dart';

class ProjectRepository {
  ProjectRepository({DbHelper? helper})
      : _helper = helper ?? DbHelper.instance;

  final DbHelper _helper;

  static const String _table = DbHelper.tableProjects;

  // CREATE: Menambahkan proyek
  Future<int> insert(Project project) async {
    final db = await _helper.database;

    return await db.insert(
      _table,
      project.toMap(),
    );
  }

  // READ: Menampilkan semua proyek
  Future<List<Project>> getAll({
    String query = '',
  }) async {
    final db = await _helper.database;

    final rows = await db.query(
      _table,
      where: query.isEmpty ? null : 'title LIKE ?',
      whereArgs: query.isEmpty ? null : ['%$query%'],
      orderBy: 'is_favorite DESC, created_at DESC',
    );

    return rows.map((row) => Project.fromMap(row)).toList();
  }

  // Menghitung jumlah proyek
  Future<int> count() async {
    final db = await _helper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM $_table',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  // UPDATE: Memperbarui proyek
  Future<int> update(Project project) async {
    final db = await _helper.database;

    return await db.update(
      _table,
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  // DELETE: Menghapus proyek
  Future<int> delete(int id) async {
    final db = await _helper.database;

    return await db.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}