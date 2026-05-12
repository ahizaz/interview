import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/app_messenger.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  final AuthRepository _authRepository;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  final isLoading = false.obs;

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      AppMessenger.showError('Email and password are required.');
      return;
    }

    isLoading.value = true;
    try {
      await _authRepository.signIn(email: email, password: password);
      AppRouter.go('/home');
    } catch (error) {
      AppMessenger.showError(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      AppMessenger.showError('Name, email, and password are required.');
      return;
    }

    isLoading.value = true;
    try {
      await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
      );
      AppMessenger.showInfo('Registration success. Please log in.');
      AppRouter.go('/login');
    } catch (error) {
      AppMessenger.showError(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      await _authRepository.signOut();
      AppRouter.go('/login');
    } catch (error) {
      AppMessenger.showError(error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
