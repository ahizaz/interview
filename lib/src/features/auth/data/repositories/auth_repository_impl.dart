import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);

  final AuthRemoteDataSource _remote;

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _remote.getCurrentUser();
    if (user == null) return null;
    return _mapUser(user);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await _remote.signIn(email: email, password: password);
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    await _remote.signUp(email: email, password: password, name: name);
  }

  @override
  Future<void> signOut() async {
    await _remote.signOut();
  }

  AppUser _mapUser(User user) {
    final name = user.userMetadata?['name'] as String?;
    return AppUser(id: user.id, email: user.email ?? '', name: name);
  }
}
