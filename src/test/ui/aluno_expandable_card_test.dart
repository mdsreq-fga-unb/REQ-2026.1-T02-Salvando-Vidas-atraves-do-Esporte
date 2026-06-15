import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno_mock.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/editar_aluno_page.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/widgets/aluno_expandable_card.dart';
import 'package:logger/logger.dart';

import 'aluno_expandable_card_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlunoService>(), MockSpec<Logger>()])
void main() {
  late MockAlunoService mockAlunoService;
  late MockLogger mockLogger;

  // Pega um aluno ativo e cria uma versão inativa para os testes
  final Aluno alunoAtivo = alunosMock.first;
  final Aluno alunoInativo = Aluno(
    id: alunoAtivo.id,
    nome: alunoAtivo.nome,
    email: alunoAtivo.email,
    cpf: alunoAtivo.cpf,
    faixa: alunoAtivo.faixa,
    grau: alunoAtivo.grau,
    tipoSanguineo: alunoAtivo.tipoSanguineo,
    dataEntrada: alunoAtivo.dataEntrada,
    nascimento: alunoAtivo.nascimento,
    contato: alunoAtivo.contato,
    ativo: false,
    federado: alunoAtivo.federado,
    idFicha: alunoAtivo.idFicha,
    idTurma: alunoAtivo.idTurma,
    idResponsavel: alunoAtivo.idResponsavel,
  );

  setUp(() {
    mockAlunoService = MockAlunoService();
    mockLogger = MockLogger();
  });

  Widget createWidgetUnderTest(Aluno aluno) {
    return ProviderScope(
      overrides: [
        alunoServiceProvider.overrideWithValue(mockAlunoService),
        loggerProvider.overrideWithValue(mockLogger),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [AlunoExpandableCard(aluno: aluno, responsavel: null)],
          ),
        ),
      ),
    );
  }

  group('AlunoExpandableCard Widget Test', () {
    testWidgets('Não deve renderizar nada se o aluno estiver inativo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(alunoInativo));

      // O widget deve retornar um SizedBox.shrink(), então não achamos o Card
      expect(
        find.byKey(Key('${alunoInativo.nome} - ${!alunoInativo.ativo}')),
        findsNothing,
      );
    });

    testWidgets('Deve mostrar informações básicas quando não expandido', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(alunoAtivo));

      expect(find.text(alunoAtivo.nome), findsOneWidget);
      expect(
        find.text('Turma: ${alunoAtivo.idTurma ?? "N/A"}'),
        findsOneWidget,
      );

      // Informações detalhadas não devem estar visíveis
      expect(find.textContaining('CPF:'), findsNothing);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('Deve expandir e mostrar detalhes ao ser clicado', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createWidgetUnderTest(alunoAtivo));

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Verifica se os detalhes e o botão de editar apareceram
      final richTextFinder = find.byWidgetPredicate(
        (widget) =>
            widget is RichText &&
            widget.text.toPlainText() == 'CPF: ${alunoAtivo.cpf}',
      );
      expect(richTextFinder, findsOneWidget);
      expect(find.text('Editar Informações'), findsOneWidget);
    });

    testWidgets(
      'Deve navegar para a página de edição ao clicar no botão "Editar"',
      (WidgetTester tester) async {
        // Aumenta o tamanho da tela para evitar o overflow na página de edição
        tester.binding.window.physicalSizeTestValue = const Size(1360, 2340);
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

        await tester.pumpWidget(createWidgetUnderTest(alunoAtivo));

        await tester.tap(find.byType(InkWell)); // Expande
        await tester.pumpAndSettle();
        await tester.tap(find.text('Editar Informações')); // Clica no botão
        await tester.pumpAndSettle();

        expect(find.byType(EditarAlunoPage), findsOneWidget);
      },
    );
  });
}
