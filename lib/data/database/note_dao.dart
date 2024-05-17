import 'package:flutter_note_app/model/note.dart';
import 'package:sqflite/sqflite.dart';

typedef NoteId = int;

class NoteDao {
  NoteDao({required this.database});

  static const tableName = "notes";

  Database database;

  Future<void> createTable(Database db) async {
    db.execute("""
        CREATE TABLE IF NOT EXISTS $tableName (
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
          title TEXT NOT NULL, 
          message TEXT NOT NULL,
          color TEXT NOT NULL,
          time TEXT NOT NULL
          );
      """);
  }

  Future<List<NoteModel>> getAll() async {
    final List<Map<String, Object?>> notesMap = await database.query(
      tableName,
      orderBy: 'time DESC',
    );
    return [for (final map in notesMap) NoteModel.fromJson(map)];
  }

  Future<NoteId> insert(NoteModel note) async {
    final nodeId = await database.insert(
      tableName,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
    return nodeId;
  }

  Future<int> update(NoteModel note) async {
    final numberOfRowChange = await database.update(
      tableName,
      note.toJson(),
      where: "id = ?",
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return numberOfRowChange;
  }

  Future<int> delete(NoteModel note) async {
    final numberOfRowChange = await database.delete(
      tableName,
      where: "id = ?",
      whereArgs: [note.id],
    );
    return numberOfRowChange;
  }
}
