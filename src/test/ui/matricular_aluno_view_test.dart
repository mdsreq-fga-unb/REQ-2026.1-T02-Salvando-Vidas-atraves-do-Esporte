import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart'; 

import 'package:salvando_vidas/ui/turma/views/matricular_aluno_view.dart';
import 'package:salvando_vidas/domain/turma/turma.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';
import 'package:salvando_vidas/main_imports.dart'; 

import 'matricular_aluno_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AlunoService>(), MockSpec<Logger>()])

class FakePesquisaAlunoNotifier extends PesquisaAluno {
  final List<Aluno> alunosMock;
  FakePesquisaAlunoNotifier(this.alunosMock);

  @override
  Future<PesquisaAlunoState> build() async {
    return PesquisaAlunoState(
      alunos: alunosMock,
      alunosFiltrados: alunosMock,
      responsaveis: {},
      mostrarInativos: false,
    );
  }
}

void main() {
  final turmaMock = Turma(
    id: 1,
    nome: 'Jiu-Jitsu Noturno',
    faixaEtaria: FaixaEtaria.adulto, 
    descricao: 'Turma de teste para adultos',
    horarioInicio: DateTime(2026, 1, 1, 19, 0),
    horarioFim: DateTime(2026, 1, 1, 21, 0),
    ativo: true,
    eSegunda: true,
    eTerca: false,
    eQuarta: true,
    eQuinta: false,
    eSexta: true,
    eSabado: false,
    eDomingo: false,
  );

  final alunoElegivelMock = Aluno(
    id: 10,
    nome: 'Carlos Silva',
    cpf: '11122233344',
    nascimento: DateTime(2000, 1, 1), 
    email: 'carlos@email.com',
    faixa: Faixa.branca,
    grau: 1,
    tipoSanguineo: TipoSanguineo.aPositivo,
    dataEntrada: DateTime.now(),
    ativo: true, 
    federado: false,
    pMedica1: false, pMedica2: false, pMedica3: false, pMedica4: false, pMedica5: false,
    idTurma: 99, 
  );

  group('MatricularAlunoView - Testes de Tela (Frente B)', () {
    late MockAlunoService mockAlunoService;
    late MockLogger mockLogger;

    setUp(() {
      mockAlunoService = MockAlunoService();
      mockLogger = MockLogger();
    });

    Widget criarAmbienteDeTeste() {
      return ProviderScope(
        overrides: [
          // Aplicamos a liberação do Linter diretamente na linha afetada!
          // ignore: scoped_providers_should_specify_dependencies
          alunoServiceProvider.overrideWithValue(mockAlunoService),
          
          // ignore: scoped_providers_should_specify_dependencies
          loggerProvider.overrideWithValue(mockLogger),
          
          // ignore: scoped_providers_should_specify_dependencies
          pesquisaAlunoProvider.overrideWith(() => FakePesquisaAlunoNotifier([alunoElegivelMock])),
        ],
        child: MaterialApp(
          home: MatricularAlunoView(turma: turmaMock),
        ),
      );
    }

    testWidgets('Deve renderizar, listar aluno elegivel e confirmar matricula com sucesso', (WidgetTester tester) async {
      when(mockAlunoService.atualizaAluno(any, any)).thenAnswer((_) async => Future.value());

      await tester.pumpWidget(criarAmbienteDeTeste());
      await tester.pumpAndSettle();

      expect(find.text('Matricular Aluno'), findsOneWidget);
      expect(find.text('Turma: Jiu-Jitsu Noturno'), findsOneWidget);
      expect(find.text('Carlos Silva'), findsOneWidget); 

      await tester.tap(find.text('Matricular'));
      await tester.pumpAndSettle(); 

      expect(find.text('Tem certeza?'), findsOneWidget);

      await tester.tap(find.text('Confirmar'));
      await tester.pumpAndSettle(); 

      verify(mockAlunoService.atualizaAluno(10, {'id_turma': 1})).called(1);
      expect(find.text('Carlos Silva matriculado com sucesso!'), findsOneWidget);
    });
  });
}