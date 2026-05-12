import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_remote_data_source.dart';
import '../models/note_model.dart';

class NotesRepositoryImpl implements NotesRepository {
  NotesRepositoryImpl(this._remote);

  final NotesRemoteDataSource _remote;

  @override
  Future<List<Note>> getNotes(String userId) async {
    final result = await _remote.getNotes(userId);
    return result.map(NoteModel.fromMap).toList();
  }

  @override
  Future<void> addNote({
    required String userId,
    required String title,
    required String description,
  }) async {
    await _remote.addNote(
      userId: userId,
      title: title,
      description: description,
    );
  }
}
