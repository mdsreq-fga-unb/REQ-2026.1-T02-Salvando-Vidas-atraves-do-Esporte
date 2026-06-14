import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno_mock.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/editar_aluno_page.dart';

void main() {
  final Aluno alunoMenor = alunosMock.firstWhere((a) => a.idResponsavel != null); // Pedro
  final Aluno alunoMaior = alunosMock.firstWhere((a) => a.idResponsavel == null); // Lucas

  Widget createWidgetUnderTest(Aluno aluno) {
    // Para testar o Navigator.pop, a página de edição precisa ser "empurrada"
    // para a pilha de navegação, e não ser a página raiz (home).
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditarAlunoPage(aluno: aluno)),
              ),
              child: const Text('Ir para Edição'),
            ),
          ),
        ),
      ),
    );
  }

  group('EditarAlunoPage Test', () {
    testWidgets('Deve preencher os campos com os dados iniciais do aluno', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(createWidgetUnderTest(alunoMenor));

      // Navega para a página de edição
      await tester.tap(find.text('Ir para Edição'));
      await tester.pumpAndSettle();

      // Verifica os campos de texto
      expect(find.widgetWithText(TextField, alunoMenor.nome), findsOneWidget);
      expect(find.widgetWithText(TextField, alunoMenor.cpf), findsOneWidget);
      expect(find.widgetWithText(TextField, alunoMenor.contato!), findsOneWidget);

      // Verifica os dropdowns
      expect(find.widgetWithText(DropdownButtonFormField<Faixa>, alunoMenor.faixa.nomeVisivel), findsOneWidget);
      expect(find.widgetWithText(DropdownButtonFormField<TipoSanguineo>, alunoMenor.tipoSanguineo.nomeVisivel), findsOneWidget);
    });

    testWidgets('Deve navegar entre as etapas para aluno menor de idade', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(createWidgetUnderTest(alunoMenor));

      // Navega para a página de edição
      await tester.tap(find.text('Ir para Edição'));
      await tester.pumpAndSettle();

      // Etapa 1
      expect(find.text('Editar Aluno:'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Avançar'), findsOneWidget);

      // Avança para a etapa 2
      await tester.tap(find.widgetWithText(ElevatedButton, 'Avançar'));
      await tester.pumpAndSettle();

      // Etapa 2
      expect(find.text('Editar Aluno (< 18 anos):'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Salvar'), findsOneWidget);
      expect(find.textContaining('Nome do Responsável'), findsOneWidget);

      // Volta para a etapa 1
      await tester.tap(find.widgetWithText(ElevatedButton, 'Voltar'));
      await tester.pumpAndSettle();

      // Etapa 1 novamente
      expect(find.text('Editar Aluno:'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Avançar'), findsOneWidget);
    });

    testWidgets('Deve mostrar diálogo de confirmação e salvar para aluno maior de idade', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(createWidgetUnderTest(alunoMaior));

      // Navega para a página de edição
      await tester.tap(find.text('Ir para Edição'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(ElevatedButton, 'Salvar'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Avançar'), findsNothing);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Deseja salvar as\nalterações?'), findsOneWidget);

      // Toca em Confirmar
      await tester.tap(find.widgetWithText(ElevatedButton, 'Confirmar'));
      
      // Inicia a renderização do SnackBar e espera a animação de entrada dele acabar
      await tester.pumpAndSettle(); 

      // A página ainda deve existir enquanto o SnackBar está visível
      expect(find.byType(EditarAlunoPage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Aluno atualizado com sucesso!'), findsOneWidget);

      // SOLUÇÃO: Avança agressivamente 6 segundos. Isso garante que o tempo 
      // padrão de 4s do SnackBar expire com folga para disparar o Future de fechamento.
      await tester.pump(const Duration(seconds: 6));
      
      // Aguarda a animação de saída do SnackBar E a animação de Navigator.pop finalizarem
      await tester.pumpAndSettle();
      
      // Agora sim! Verifica se a página de edição foi fechada corretamente
      expect(find.byType(EditarAlunoPage), findsNothing);
      expect(find.text('Ir para Edição'), findsOneWidget);
    });

    testWidgets('Deve fechar o diálogo ao clicar em Cancelar', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(createWidgetUnderTest(alunoMaior));
      await tester.tap(find.text('Ir para Edição'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Cancelar'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
      expect(find.byType(EditarAlunoPage), findsOneWidget);
    });
  });
}