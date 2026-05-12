import 'package:get/get.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../auth/domain/repositories/auth_repository.dart';

class SplashController extends GetxController {
  SplashController(this._authRepository);

  final AuthRepository _authRepository;
  bool _started = false;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    await LocalStorageService.instance.setHasSeenSplash();
    await Future<void>.delayed(const Duration(milliseconds: 1200));

    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      AppRouter.go('/login');
    } else {
      AppRouter.go('/home');
    }
  }
}
