import 'package:salvando_vidas/main_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = context.read<UserService>().isAdmin;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8F8F8), Color(0xFFE4E4E4)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () async {
                          await context.read<UserService>().logout();
                          context.go(Routes.login);
                        },
                        icon: const Icon(Icons.logout_outlined),
                        label: const Text('Deslogar'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF08216F),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 26,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF08216F),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x2A000000),
                            blurRadius: 22,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Página inicial',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF10A9D0),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            isAdmin
                                ? 'Escolha uma área para acessar.'
                                : 'Seu perfil não é administrador.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          if (!isAdmin) ...[
                            SizedBox(height: 8),
                            Text(
                              'A seção de administrador fica visível apenas para login ADM.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFD8DDE6),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    if (isAdmin) ...[
                      _MenuCard(
                        title: 'Administrador',
                        subtitle: 'Gerencie cadastros e acessos',
                        color: const Color(0xFF11A6BF),
                        icon: Icons.admin_panel_settings_outlined,
                        onTap: () => context.go(Routes.admin),
                      ),
                      const SizedBox(height: 16),
                    ],
                    _MenuCard(
                      title: 'Cadastros',
                      subtitle: 'Acesse uma área simples de apoio',
                      color: const Color(0xFF2457F0),
                      icon: Icons.folder_open_outlined,
                      onTap: () => context.go(Routes.cadastros),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFD8DDE6),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF08216F),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF1E2B61),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF2457F0)),
            ],
          ),
        ),
      ),
    );
  }
}
