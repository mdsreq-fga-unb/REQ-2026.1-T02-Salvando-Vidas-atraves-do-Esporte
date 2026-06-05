import 'package:salvando_vidas/main_imports.dart';

import 'package:salvando_vidas/ui/home/admin_page.dart';
import 'package:salvando_vidas/ui/home/cadastros_page.dart';
import 'package:salvando_vidas/ui/home/home_page.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => HomePage()),
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),
    GoRoute(path: Routes.admin, builder: (context, state) => AdminPage()),
    GoRoute(
      path: Routes.cadastros,
      builder: (context, state) => CadastrosPage(),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) async {
    final userService = context.read<UserService>();

    switch (await userService.isLoggedIn()) {
      case Failure(message: final m, error: final e):
        context.read<Logger>().e(m, error: e);
        return null;
      case Success(value: final v):
        return !v ? Routes.login : null;
    }
  },
);
