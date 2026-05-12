import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/notes/presentation/pages/add_note_page.dart';
import '../../features/notes/presentation/pages/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../services/supabase_service.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static late GoRouter router;
  static final _authRefresh = AuthRefreshListenable();

  static GoRouter create({required bool showSplash}) {
    router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: showSplash ? '/splash' : '/home',
      refreshListenable: _authRefresh,
      routes: [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/add-note',
          builder: (context, state) => const AddNotePage(),
        ),
      ],
      redirect: (context, state) {
        final isLoggedIn =
            SupabaseService.client.auth.currentSession?.user != null;
        final location = state.matchedLocation;
        final inAuth = location == '/login' || location == '/register';
        final inSplash = location == '/splash';

        if (!isLoggedIn && !inAuth && !inSplash) {
          return '/login';
        }

        if (isLoggedIn && inAuth) {
          return '/home';
        }

        return null;
      },
    );

    return router;
  }

  static void go(String location) {
    router.go(location);
  }

  static void pop() {
    if (router.canPop()) {
      router.pop();
    }
  }
}

class AuthRefreshListenable extends ChangeNotifier {
  AuthRefreshListenable() {
    _subscription = SupabaseService.client.auth.onAuthStateChange.listen(
      (_) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
