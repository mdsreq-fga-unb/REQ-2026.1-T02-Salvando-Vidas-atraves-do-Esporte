// Pagina de configuração onde pode ser acessado edição de perfil voluntário, dark mode, deslogar
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/main_imports.dart';

class Configuracao extends ConsumerStatefulWidget {
  const Configuracao({super.key});

  @override
  ConsumerState<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends ConsumerState<Configuracao> {
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    final user = this.ref.read(userServiceProvider).localUser!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // PERFIL
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 30, child: Icon(Icons.person)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.nome,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      // EDITAR PERFIL
                      onPressed: () {
                        // Navega para a tela de edição
                        context.push(Routes.editarPerfil);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Container(
                // TEMA
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                    },
                    title: const Text('Modo escuro'),
                    secondary: const Icon(Icons.dark_mode),
                  ),
                ),
              ),

              const Expanded(child: SizedBox()),
              SizedBox(
                // LOGOUT
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await this.ref.read(userServiceProvider).logout();
                    if (!context.mounted) return;
                    context.go(Routes.login);
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Deslogar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 5), // espaço extra da navbar
            ],
          ),
        ),
      ),
    );
  }
}