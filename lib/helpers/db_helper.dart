import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper db = DBHelper._();

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'comments.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_comments(id INTEGER PRIMARY KEY, userName TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

   Future<void> delete(String id) async {
    final db = await DBHelper.database();
    db.delete('user_comments', where: "id = ?", whereArgs: [id]);
  }
}
