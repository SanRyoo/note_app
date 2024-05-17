// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      title: json['title'] as String,
      message: json['message'] as String,
      color: $enumDecode(_$NoteColorsEnumMap, json['color']),
      time: DateTime.parse(json['time'] as String),
    )..id = (json['id'] as num?)?.toInt();

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'color': _$NoteColorsEnumMap[instance.color]!,
      'time': instance.time.toIso8601String(),
    };

const _$NoteColorsEnumMap = {
  NoteColors.purple: 'purple',
  NoteColors.blue: 'blue',
  NoteColors.amber: 'amber',
  NoteColors.green: 'green',
  NoteColors.red: 'red',
};
