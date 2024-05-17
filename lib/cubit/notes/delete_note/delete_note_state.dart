// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:equatable/equatable.dart';

sealed class DeleteNoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeleteNoteInitialState extends DeleteNoteState {}

class DeleteNoteLoadingState extends DeleteNoteState {}

class DeleteNoteSuccessState extends DeleteNoteState {
  DeleteNoteSuccessState({required this.result});

  final int result;

  @override
  List<Object?> get props => [result];
}

class DeleteNoteErrorState extends DeleteNoteState {
  DeleteNoteErrorState({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
