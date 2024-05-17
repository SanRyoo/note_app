import 'package:flutter/material.dart';
import 'package:flutter_note_app/model/note.dart';
import 'package:flutter_note_app/screen/detail/detail_screen.dart';
import 'package:flutter_note_app/screen/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class RouterUri {
  static const home = "/";
  static const detail = "/detail";
}

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouterUri.home,
    routes: [
      GoRoute(
        path: RouterUri.home,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: RouterUri.detail,
        pageBuilder: (context, state) => MaterialPage<void>(
          child: DetailScreen(
            note: state.extra as NoteModel?,
          ),
        ),
      ),
    ],
  );
}
