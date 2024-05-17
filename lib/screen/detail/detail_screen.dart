// ignore_for_file: must_be_immutable, no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/cubit/notes/insert_note/insert_note_cubit.dart';
import 'package:note_app/cubit/notes/insert_note/insert_note_state.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/widgets/debounce_throttle.dart';
import 'package:note_app/widgets/snack_bar.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.note});

  NoteModel? note;

  @override
  State<DetailScreen> createState() => _DetailScreenState(note: note);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState({required this.note});

  NoteModel? note;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int index = 0;
  late TextEditingController _titleController;
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _messageController = TextEditingController();

    if (note != null) {
      _titleController.text = note!.title;
      _messageController.text = note!.message;

      index = NoteColors.values
          .map((e) => e.value)
          .toList()
          .indexOf(note!.color.value);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final throttle = Throttle(milliseconds: 1000);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(
            "Detail",
          ),
          backgroundColor: Colors.purple[400],
          foregroundColor: Colors.white,
        ),
        floatingActionButton: BlocListener(
          bloc: context.read<InsertUpdateNoteCubit>(),
          listener: (context, state) {
            if (state is InsertNoteSuccessState && state.noteId > 0) {
              context.pop();
              return;
            }
            if (state is UpdateNoteSuccessState && state.result > 0) {
              context.pop();
              return;
            }
            if (state is InsertUpdateNoteErrorState) {
              final snackBar = SnackBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: CustomSnackBar(
                  meesage: state.error,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: FloatingActionButton(
            onPressed: () {
              throttle(() {
                if (note == null) {
                  context.read<InsertUpdateNoteCubit>().insert(
                        NoteModel(
                          title: _titleController.text,
                          message: _messageController.text,
                          color: NoteColors.values[index],
                          time: DateTime.now(),
                        ),
                      );
                } else {
                  context.read<InsertUpdateNoteCubit>().update(
                        NoteModel.fullConstructor(
                          id: note?.id ?? -1,
                          title: _titleController.text,
                          message: _messageController.text,
                          color: NoteColors.values[index],
                          time: DateTime.now(),
                        ),
                      );
                }
              });
            },
            shape: const CircleBorder(),
            backgroundColor: Colors.purple[400],
            elevation: 10,
            child: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: NoteColors.values[index].value,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 6);
                },
                itemCount: NoteColors.values.length,
                padding: const EdgeInsets.all(6),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        this.index = index;
                      });
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: NoteColors.values[index].value,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: this.index == index ? 2 : 0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: "Note's title",
              ),
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                hintText: "Note's message",
              ),
            )
          ],
        ),
      ),
    );
  }
}
