import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/app_messenger.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';

class NotesController extends GetxController {
  NotesController(this._notesRepository, this._authRepository);

  final NotesRepository _notesRepository;
  final AuthRepository _authRepository;

  final notes = <Note>[].obs;
  final isLoading = false.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool _loaded = false;

  Future<void> loadNotesIfNeeded() async {
    if (_loaded) return;
    _loaded = true;
    await loadNotes();
  }

  Future<void> loadNotes() async {
    final user = await _authRepository.getCurrentUser();
    if (user == null) return;

    isLoading.value = true;
    try {
      final result = await _notesRepository.getNotes(user.id);
      notes.assignAll(result);
    } catch (error) {
      AppMessenger.showError(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNote() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      AppMessenger.showError('Title and description are required.');
      return;
    }

    final user = await _authRepository.getCurrentUser();
    if (user == null) return;

    isLoading.value = true;
    try {
      await _notesRepository.addNote(
        userId: user.id,
        title: title,
        description: description,
      );
      titleController.clear();
      descriptionController.clear();
      await loadNotes();
      AppRouter.pop();
    } catch (error) {
      AppMessenger.showError(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
