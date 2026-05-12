import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/services/app_bindings.dart';
import 'src/core/services/local_storage_service.dart';
import 'src/core/services/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.instance.init();
  await SupabaseService.init();
  AppBindings.init();

  final showSplash = !LocalStorageService.instance.hasSeenSplash;

  runApp(InterviewApp(showSplash: showSplash));
}
