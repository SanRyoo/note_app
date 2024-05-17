// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:note_app/core/repository/notes_repository.dart';
import 'package:note_app/cubit/notes/get_notes/get_notes_state.dart';
import 'package:note_app/di/locator.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitialState());

  final NotesRepository repository = sl();

  void getAllNotes({required bool isFirstTime}) async {
    try {
      if (isFirstTime) {
        emit(GetNotesLoadingState());
      }
      final notes = await repository.getAllNotes();
      emit(GetNotesSuccessState(notes: notes));
      // ignore: unused_catch_clause, empty_catches
    } on Exception catch (e) {
      emit(GetNotesErrorState(error: e.toString()));
    }
  }
}
