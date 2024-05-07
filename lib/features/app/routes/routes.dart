import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moodjournal/features/app/app.dart';
import 'package:moodjournal/features/login/login.dart';
import 'package:moodjournal/features/sign_up/sign_up.dart';

import '../../home/view/home_page.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/regisget",
        builder: (context, state) => const SignUpPage(),
      ),
    ],
    redirect: (context,state) {
      print(state.fullPath);
      final status = context.watch<AppBloc>();
      // final status = context.watch((AppBloc bloc) => bloc.state);

      final isLoggedIn = status.state.status == AppStatus.authenticated;
      print(status.state.status);
      final isLoggingIn = state.fullPath == '/login';

      if (!isLoggingIn && !isLoggedIn) return '/login';
      if (isLoggedIn && isLoggingIn) return "/";

      return null;
    },
  );

  static GoRouter get router => _router;
}
