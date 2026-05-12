import '../entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> signOut();
}
