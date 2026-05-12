import 'package:get/get.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/notes/data/datasources/notes_remote_data_source.dart';
import '../../features/notes/data/repositories/notes_repository_impl.dart';
import '../../features/notes/presentation/controllers/notes_controller.dart';
import '../../features/splash/presentation/controllers/splash_controller.dart';

class AppBindings {
  static void init() {
    final authRemote = AuthRemoteDataSource();
    final authRepository = AuthRepositoryImpl(authRemote);

    final notesRemote = NotesRemoteDataSource();
    final notesRepository = NotesRepositoryImpl(notesRemote);

    Get.put(AuthController(authRepository));
    Get.put(NotesController(notesRepository, authRepository));
    Get.put(SplashController(authRepository));
  }
}
