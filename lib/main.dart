import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/cubit/notes/delete_note/delete_note_cubit.dart';
import 'package:flutter_note_app/cubit/notes/get_notes/get_notes_cubit.dart';
import 'package:flutter_note_app/cubit/notes/insert_note/insert_note_cubit.dart';
import 'package:flutter_note_app/di/locator.dart';
import 'package:flutter_note_app/router/app_router.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetNotesCubit()..getAllNotes(isFirstTime: true),
        ),
        BlocProvider(
          create: (context) => InsertUpdateNoteCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteNoteCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          primaryColor: Colors.purple,
          useMaterial3: true,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
