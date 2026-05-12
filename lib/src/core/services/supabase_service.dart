import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String anonKey = 'sb_publishable_VPtjbKgtH54gTwoTv83tIw_eneai8A5';

  static Future<void> init() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: anonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
