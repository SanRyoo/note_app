import 'dart:async';
import 'package:flutter_note_app/data/database/note_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatatbaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullpath async {
    const databaseName = "notes.db";
    final path = await getDatabasesPath();
    return join(path, databaseName);
  }

  Future<Database> _initialize() async {
    final path = await fullpath;
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
      singleInstance: true,
    );
    return database;
  }

  FutureOr<void> onCreate(Database db, int version) {
    NoteDao(database: db).createTable(db);
  }
}
