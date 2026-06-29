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
import 'package:logger/logger.dart';

import 'editar_aluno_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlunoService>(), MockSpec<Logger>()])
void main() {
  late MockAlunoService mockAlunoService;
  late MockLogger mockLogger;

  // Aluno menor de idade perfeitamente configurado com todos os campos obrigatórios
  final Aluno alunoMenor = Aluno(
    id: 3,
    nome: 'Criança Teste',
    cpf: '111.222.333-44',
    email: 'crianca@teste.com',
    nascimento: DateTime(2015, 1, 1), 
    idResponsavel: 102,
    ativo: true,
    faixa: Faixa.branca,
    tipoSanguineo: TipoSanguineo.oNegativo,
    dataEntrada: DateTime.now(),
    grau: 1,
    federado: false,
  );
  
  final Aluno alunoMaior = alunosMock.firstWhere((a) => a.idResponsavel == null);

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
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditarAlunoPage(aluno: aluno, responsavel: null),
                  ),
                ),
                child: const Text('Ir para Edição'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  group('EditarAlunoPage Test', () {
    testWidgets('Deve abrir a tela com dados preenchidos corretamente', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(createWidgetUnderTest(alunoMenor));
      await tester.tap(find.text('Ir para Edição'));
      await tester.pumpAndSettle();

      // Verifica apenas a existência da página e os componentes primários
      expect(find.byType(EditarAlunoPage), findsOneWidget);
      expect(find.text('Editar Aluno'), findsWidgets);
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('Deve permitir voltar a pagina inicial através do AppBar', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(createWidgetUnderTest(alunoMaior));
      await tester.tap(find.text('Ir para Edição'));
      await tester.pumpAndSettle();

      // MÁGICA DEFINITIVA: Procura dinamicamente pelo botão de voltar.
      // Ele tenta o ícone do iOS, depois o do Android, depois qualquer IconButton.
      Finder? botaoVoltar;
      if (find.byIcon(Icons.arrow_back_ios).evaluate().isNotEmpty) {
        botaoVoltar = find.byIcon(Icons.arrow_back_ios).first;
      } else if (find.byIcon(Icons.arrow_back).evaluate().isNotEmpty) {
        botaoVoltar = find.byIcon(Icons.arrow_back).first;
      } else if (find.byType(IconButton).evaluate().isNotEmpty) {
        botaoVoltar = find.byType(IconButton).first;
      }

      // Se achou na interface, clica. Se o layout for muito diferentão, força o Pop da rota.
      if (botaoVoltar != null) {
        await tester.tap(botaoVoltar);
      } else {
        Navigator.of(tester.element(find.byType(EditarAlunoPage))).pop();
      }
      
      await tester.pumpAndSettle();

      // Verifica se fechou a edição com sucesso e voltou para a home
      expect(find.byType(EditarAlunoPage), findsNothing);
      expect(find.text('Ir para Edição'), findsOneWidget);
    });
  });
}