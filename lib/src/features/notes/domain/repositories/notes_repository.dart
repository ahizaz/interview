import '../entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getNotes(String userId);
  Future<void> addNote({
    required String userId,
    required String title,
    required String description,
  });
}
