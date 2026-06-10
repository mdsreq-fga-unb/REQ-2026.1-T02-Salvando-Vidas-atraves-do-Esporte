import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/admin/views/admin_page.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/views/cadastros_page.dart';
import 'package:salvando_vidas/ui/configuracao/views/configuracao.dart';
import 'package:salvando_vidas/ui/global/widgets/topbar.dart';
import 'package:salvando_vidas/ui/home/views/home_page.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';
import 'package:salvando_vidas/ui/global/widgets/navbar.dart';
import 'package:salvando_vidas/ui/turma/views/turma.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: Routes.home,

  routes: [

    // ROTAS SEM NAVBAR
    GoRoute(path: Routes.login, builder: (context, state) => LoginPage(),),

    // ROTAS COM NAVBAR
    ShellRoute(builder: (context, state, child) {return MainScaffold(child: child);},

      routes: [

        GoRoute(path: Routes.home, builder: (context, state) => HomePage(),
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
        ),

        GoRoute(path: Routes.admin, builder: (context, state) => AdminPage(),),

        GoRoute(path: Routes.cadastros, builder: (context, state) => CadastrosPage(),),

        GoRoute(path: Routes.configuracao, builder: (context, state) => Configuracao(),),

        GoRoute(path: Routes.turma, builder: (context, state) => Turma(),),
      ],
    ),
  ],
);

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    final keyboardOpen =
        MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(

      appBar: const TopBar(),
      body: child,

      bottomNavigationBar:
          keyboardOpen ? null : const NavBar(),
    );
  }
}