// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:intl/intl.dart';

class NoteItem extends StatelessWidget {
  NoteItem({
    super.key,
    required this.note,
    required this.onClick,
    required this.onDismissed,
  });

  NoteModel note;
  void Function(NoteModel) onClick;
  void Function(NoteModel) onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(note),
      onDismissed: (direction) {
        onDismissed(note);
      },
      child: GestureDetector(
        onTap: () {
          onClick(note);
        },
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: note.color.value,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                note.message,
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                DateFormat('HH:mm dd/MM/yyyy').format(note.time),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
