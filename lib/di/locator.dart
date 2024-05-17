import 'package:note_app/core/repository/notes_repository.dart';
import 'package:note_app/data/database/db_service.dart';
import 'package:note_app/data/database/note_dao.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future setUpLocator() async {
  // Database
  final database = await DatatbaseService().database;
  sl.registerLazySingleton(() => database);

  // Dao
  sl.registerLazySingleton(() => NoteDao(database: sl()));

  // Repository
  sl.registerLazySingleton<NotesRepository>(
      () => NotesRepositoryIplm(dao: sl()));
}
