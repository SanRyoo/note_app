// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:note_app/core/repository/notes_repository.dart';
import 'package:note_app/cubit/notes/delete_note/delete_note_state.dart';
import 'package:note_app/di/locator.dart';
import 'package:note_app/model/note.dart';

class DeleteNoteCubit extends Cubit<DeleteNoteState> {
  DeleteNoteCubit() : super(DeleteNoteInitialState());

  final NotesRepository repository = sl();

  void delete(NoteModel note) async {
    try {
      emit(DeleteNoteLoadingState());
      final result = await repository.delete(note);
      emit(DeleteNoteSuccessState(result: result));
      // ignore: unused_catch_clause, empty_catches
    } on Exception catch (e) {
      emit(DeleteNoteErrorState(error: e.toString()));
    }
  }
}
