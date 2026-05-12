import '../../../../core/services/supabase_service.dart';

class NotesRemoteDataSource {
  Future<List<Map<String, dynamic>>> getNotes(String userId) async {
    final response = await SupabaseService.client
        .from('notes')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> addNote({
    required String userId,
    required String title,
    required String description,
  }) async {
    await SupabaseService.client.from('notes').insert({
      'user_id': userId,
      'title': title,
      'description': description,
    });
  }
}
