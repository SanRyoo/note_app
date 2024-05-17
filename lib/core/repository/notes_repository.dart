// ignore_for_file: file_names
import 'package:flutter_note_app/data/database/note_dao.dart';
import 'package:flutter_note_app/model/note.dart';

abstract interface class NotesRepository {
  Future<List<NoteModel>> getAllNotes();

  Future<NoteId> insert(NoteModel note);

  Future<int> update(NoteModel note);

  Future<int> delete(NoteModel note);
}

class NotesRepositoryIplm implements NotesRepository {
  NotesRepositoryIplm({required this.dao});

  NoteDao dao;

  @override
  Future<List<NoteModel>> getAllNotes() {
    return dao.getAll();
  }

  @override
  Future<NoteId> insert(NoteModel note) {
    return dao.insert(note);
  }

  @override
  Future<int> update(NoteModel note) {
    return dao.update(note);
  }

  @override
  Future<int> delete(NoteModel note) {
    return dao.delete(note);
  }
}
