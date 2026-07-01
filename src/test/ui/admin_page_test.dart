import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Ajuste os imports abaixo conforme necessário para o seu projeto
import 'package:salvando_vidas/ui/admin/views/admin_page.dart';

void main() {
  // O nosso ambiente de teste agora ganha um ProviderScope para 
  // que o ConsumerWidget funcione sem dar erro de escopo.
  Widget criarAmbienteDeTeste() {
    return const ProviderScope(
      child: MaterialApp(
        home: AdminPage(),
      ),
    );
  }

  group('AdminPage - Testes de Tela', () {
    
    testWidgets('Deve renderizar os cartoes principais da area administrativa', (WidgetTester tester) async {
      // 1. Renderizar a tela
      await tester.pumpWidget(criarAmbienteDeTeste());

      // O pumpAndSettle garante que os gradientes e sombras terminaram de renderizar
      await tester.pumpAndSettle(); 

      // 2 & 3. Procurar e Validar os títulos dos cartões
      expect(find.text('Cadastrar Voluntário'), findsOneWidget);
      expect(find.text('Editar Voluntário'), findsOneWidget);

      // Valida as descrições (subtítulos) com as quebras de linha exatas
      expect(find.text('Cadastre novos voluntários\npara acessar a aplicação'), findsOneWidget);
      expect(find.text('Edite as informações dos\nvoluntários'), findsOneWidget);

      // Valida se os ícones específicos foram desenhados na tela
      expect(find.byIcon(Icons.person_add_alt_1_outlined), findsOneWidget);
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
      
      // Como a tela tem dois cartões, esperamos encontrar duas setas apontando para a direita
      expect(find.byIcon(Icons.chevron_right_rounded), findsNWidgets(2));
    });
    
  });
}