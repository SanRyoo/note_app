import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class NoteModel {
  int? id;
  String title;
  String message;
  NoteColors color;
  DateTime time;

  NoteModel({
    required this.title,
    required this.message,
    required this.color,
    required this.time,
  });

  NoteModel.fullConstructor({
    required this.id,
    required this.title,
    required this.message,
    required this.color,
    required this.time,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);
}

enum NoteColors {
  purple(value: Colors.deepPurple),
  blue(value: Colors.blue),
  amber(value: Colors.amber),
  green(value: Colors.green),
  red(value: Colors.red);

  const NoteColors({required this.value});

  final Color? value;
}
