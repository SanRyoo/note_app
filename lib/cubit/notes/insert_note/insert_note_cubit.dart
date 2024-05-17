// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:note_app/core/repository/notes_repository.dart';
import 'package:note_app/cubit/notes/insert_note/insert_note_state.dart';
import 'package:note_app/di/locator.dart';
import 'package:note_app/model/note.dart';

class InsertUpdateNoteCubit extends Cubit<InsertUpdateNoteState> {
  InsertUpdateNoteCubit() : super(InsertUpdateNoteInitialState());

  final NotesRepository repository = sl();

  void insert(NoteModel note) async {
    try {
      if (note.title.isEmpty) {
        emit(InsertUpdateNoteLoadingState());
        emit(InsertUpdateNoteErrorState(
          error: "Note title can not be blank",
        ));
        return;
      }
      if (note.message.isEmpty) {
        emit(InsertUpdateNoteLoadingState());
        emit(InsertUpdateNoteErrorState(
          error: "Note message can not be blank",
        ));
        return;
      }
      emit(InsertUpdateNoteLoadingState());
      final noteId = await repository.insert(note);
      emit(InsertNoteSuccessState(noteId: noteId));
      // ignore: unused_catch_clause, empty_catches
    } on Exception catch (e) {
      emit(InsertUpdateNoteErrorState(error: e.toString()));
    }
  }

  void update(NoteModel note) async {
    try {
      if (note.title.isEmpty) {
        emit(InsertUpdateNoteLoadingState());
        emit(InsertUpdateNoteErrorState(
          error: "Note title can not be blank",
        ));
        return;
      }
      if (note.message.isEmpty) {
        emit(InsertUpdateNoteLoadingState());
        emit(InsertUpdateNoteErrorState(
          error: "Note message can not be blank",
        ));
        return;
      }
      emit(InsertUpdateNoteLoadingState());
      final result = await repository.update(note);
      emit(UpdateNoteSuccessState(result: result));
      // ignore: unused_catch_clause, empty_catches
    } on Exception catch (e) {
      emit(InsertUpdateNoteErrorState(error: e.toString()));
    }
  }
}
