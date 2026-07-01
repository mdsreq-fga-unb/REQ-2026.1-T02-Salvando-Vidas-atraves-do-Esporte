import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/admin/views/admin_page.dart';
import 'package:salvando_vidas/ui/admin/views/cadastrar_voluntario_page.dart';
import 'package:salvando_vidas/ui/admin/views/editar_voluntario_page.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/views/cadastros_page.dart';
import 'package:salvando_vidas/ui/configuracao/views/configuracao.dart';
import 'package:salvando_vidas/ui/global/widgets/navbar.dart';
import 'package:salvando_vidas/ui/home/views/home_page.dart';
import 'package:salvando_vidas/ui/login/views/login_page.dart';
import 'package:salvando_vidas/ui/turma/views/turma.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/pesquisa_alunos_imports.dart';
import 'package:salvando_vidas/ui/configuracao/views/editar_perfil_page.dart';
import 'package:salvando_vidas/ui/inventario/views/inventario.dart';
import 'package:salvando_vidas/ui/inventario/views/doacoes_perdas_page.dart';
import 'package:salvando_vidas/ui/inventario/views/emprestimo_devolucao_page.dart';
import 'package:salvando_vidas/ui/emprestimo/views/historico_emprestimos_page.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    initialLocation: Routes.home,

    routes: [
      // ROTAS SEM NAVBAR
      GoRoute(path: Routes.login, builder: (context, state) => LoginPage()),

      // NOVA ROTA DA TELA DE EDIÇÃO DE PERFIL:
      GoRoute(
        path: Routes.editarPerfil,
        builder: (context, state) => const EditarPerfilPage(),
      ),

      // ROTAS COM NAVBAR
      ShellRoute(
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },

        routes: [
          GoRoute(
            path: Routes.home,
            builder: (context, state) => HomePage(),
            redirect: (BuildContext context, GoRouterState state) async {
              final userService = ref.read(userServiceProvider);
              final logger = ref.read(loggerProvider);

              try {
                final isLoggedIn = await userService.isLoggedIn();
                return !isLoggedIn ? Routes.login : null;
              } catch (e) {
                logger.e('Erro ao verificar estado da sessão', error: e);
                return Routes.login;
              }
            },
          ),

          GoRoute(path: Routes.admin, builder: (context, state) => AdminPage()),

          GoRoute(
            path: Routes.cadastrarVoluntario,
            builder: (context, state) => const CadastrarVoluntarioPage(),
          ),

          GoRoute(
            path: Routes.editarVoluntario,
            builder: (context, state) => const EditarVoluntarioPage(),
          ),

          GoRoute(
            path: Routes.cadastros,
            builder: (context, state) => CadastrosPage(),
          ),

          GoRoute(
            path: Routes.configuracao,
            builder: (context, state) => Configuracao(),
          ),

          GoRoute(path: Routes.turma, builder: (context, state) => TurmaPage()),

          GoRoute(
            path: Routes.buscaAluno,
            builder: (context, state) => const PesquisaAlunosPage(),
          ),

          GoRoute(path: Routes.inventario, builder: (context, state) => Inventario()),

          GoRoute(
            path: Routes.doacoesPerdas,
            builder: (context, state) => const DoacoesPerdasPage(),
          ),

          GoRoute(
            path: Routes.emprestimoDevolucao,
            builder: (context, state) {
              final modo = state.extra is bool ? (state.extra as bool) : null;
              return EmprestimoDevolucaoPage(modoInicialEmprestar: modo);
            },
          ),
          GoRoute(
            path: Routes.historicoEmprestimos,
            builder: (context, state) => const HistoricoEmprestimosPage(),
          ),
        ],
      ),
    ],
  );
}

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: const TopBar(),
      body: child,
      bottomNavigationBar: keyboardOpen ? null : const NavBar(),
    );
  }
}