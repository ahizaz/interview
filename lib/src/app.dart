import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/app_messenger.dart';

class InterviewApp extends StatelessWidget {
  const InterviewApp({super.key, required this.showSplash});

  final bool showSplash;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.create(showSplash: showSplash);

    return MaterialApp.router(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      scaffoldMessengerKey: AppMessenger.key,
      routerConfig: router,
    );
  }
}
