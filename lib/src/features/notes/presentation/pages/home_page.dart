import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/router/app_router.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../controllers/notes_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final notesController = Get.find<NotesController>();
    final authController = Get.find<AuthController>();
    notesController.loadNotesIfNeeded();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            onPressed: authController.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(
        () {
          if (notesController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (notesController.notes.isEmpty) {
            return const Center(child: Text('No notes yet.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notesController.notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final note = notesController.notes[index];
              return Card(
                child: ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.description),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRouter.go('/add-note'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
