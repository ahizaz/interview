import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    controller.start();

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.note_alt_outlined, size: 64),
            SizedBox(height: 12),
            Text('Notes App', style: TextStyle(fontSize: 20)),//
          ],
        ),
      ),
    );
  }
}
