// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:note_app/data/database/note_dao.dart';

sealed class InsertUpdateNoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InsertUpdateNoteInitialState extends InsertUpdateNoteState {}

class InsertUpdateNoteLoadingState extends InsertUpdateNoteState {}

class InsertNoteSuccessState extends InsertUpdateNoteState {
  InsertNoteSuccessState({required this.noteId});

  final NoteId noteId;

  @override
  List<Object?> get props => [noteId];
}

class UpdateNoteSuccessState extends InsertUpdateNoteState {
  UpdateNoteSuccessState({required this.result});

  final int result;

  @override
  List<Object?> get props => [result];
}

class InsertUpdateNoteErrorState extends InsertUpdateNoteState {
  InsertUpdateNoteErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
