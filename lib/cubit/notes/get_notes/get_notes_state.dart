// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:note_app/model/note.dart';

sealed class GetNotesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotesInitialState extends GetNotesState {}

class GetNotesLoadingState extends GetNotesState {}

class GetNotesSuccessState extends GetNotesState {
  GetNotesSuccessState({required this.notes});

  final List<NoteModel> notes;

  @override
  List<Object?> get props => [notes];
}

class GetNotesErrorState extends GetNotesState {
  GetNotesErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
