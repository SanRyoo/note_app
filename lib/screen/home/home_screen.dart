// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/cubit/notes/delete_note/delete_note_cubit.dart';
import 'package:flutter_note_app/cubit/notes/get_notes/get_notes_cubit.dart';
import 'package:flutter_note_app/cubit/notes/get_notes/get_notes_state.dart';
import 'package:flutter_note_app/cubit/notes/insert_note/insert_note_cubit.dart';
import 'package:flutter_note_app/router/app_router.dart';
import 'package:flutter_note_app/screen/home/widgets/note_item.dart';
import 'package:flutter_note_app/widgets/debounce_throttle.dart';
import 'package:flutter_note_app/widgets/snack_bar.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final throttle = Throttle(milliseconds: 1000);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[400],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          throttle(() async {
            await context.push(RouterUri.detail);
            context.read<GetNotesCubit>().getAllNotes(isFirstTime: false);
          });
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.purple[400],
        elevation: 10,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetNotesCubit, GetNotesState>(
      builder: (context, state) {
        if (state is GetNotesLoadingState) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
        if (state is GetNotesSuccessState) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            padding: const EdgeInsets.all(10),
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              final throttle = Throttle(milliseconds: 1000);
              return NoteItem(
                note: state.notes[index],
                onClick: (note) {
                  throttle(() async {
                    await context.push(RouterUri.detail, extra: note);
                    context
                        .read<GetNotesCubit>()
                        .getAllNotes(isFirstTime: false);
                  });
                },
                onDismissed: (note) {
                  context.read<DeleteNoteCubit>().delete(note);
                  final throttle = Throttle(milliseconds: 1000);
                  final snackBar = SnackBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: CustomSnackBar(
                      meesage: "Deleted note successfully!",
                      label: "Undo",
                      onClickAction: () {
                        throttle(() {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          context.read<InsertUpdateNoteCubit>().insert(note);
                          context
                              .read<GetNotesCubit>()
                              .getAllNotes(isFirstTime: false);
                        });
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  context.read<GetNotesCubit>().getAllNotes(isFirstTime: false);
                },
              );
            },
          );
        }
        if (state is GetNotesErrorState) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            child: Text(
              state.error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
