import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Ajuste o import abaixo se o caminho estiver diferente na sua máquina
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/pesquisa_alunos_page.dart';

void main() {
  // Como a tela usa ref.watch(), o ProviderScope é OBRIGATÓRIO.
  Widget criarAmbienteDeTeste() {
    return const ProviderScope(
      child: MaterialApp(
        home: PesquisaAlunosPage(),
      ),
    );
  }

  group('PesquisaAlunosPage - Testes de Tela (Frente A)', () {
    testWidgets('Deve renderizar a estrutura base de busca e iniciar no estado de carregamento', (WidgetTester tester) async {
      // 1. Renderizar a tela
      await tester.pumpWidget(criarAmbienteDeTeste());

      // Imediatamente após a tela ser desenhada, o provedor do Riverpod 
      // deve iniciar a busca, ativando o estado 'loading'.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // O TextField de pesquisa sempre deve ser renderizado, mesmo carregando.
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Insira o nome do aluno'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      // 2. Aguardar a requisição assíncrona terminar
      // O pumpAndSettle avança o tempo virtual do teste até as animações pararem.
      await tester.pumpAndSettle();

      // Como o teste roda isolado do banco de dados real do Supabase, o provedor
      // terminará o carregamento caindo em 'Data' vazio ou em 'Error'.
      // Vamos garantir que a interface tratou esse final e removeu o Loading.
      expect(find.byType(CircularProgressIndicator), findsNothing);

      final textoErro = find.text('Erro ao procurar por alunos.');
      final textoVazio = find.text('Nenhum aluno encontrado.');
      
      final achouErro = textoErro.evaluate().isNotEmpty;
      final achouVazio = textoVazio.evaluate().isNotEmpty;
      
      // Valida se o Riverpod devolveu a resposta para a View com segurança
      expect(
        achouErro || achouVazio, 
        true, 
        reason: 'A tela deve exibir mensagem de erro ou lista vazia após o carregamento',
      );
    });
  });
}