import 'package:go_router/go_router.dart';
import 'routes.dart';

import '../ui/auth/login_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => const LoginPage()),
  ],
);
