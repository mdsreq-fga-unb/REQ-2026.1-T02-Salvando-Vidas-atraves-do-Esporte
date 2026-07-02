import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/aluno_service/aluno_service.dart';
import 'package:salvando_vidas/data/stores/home/home_store.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/ui/home/views/home_page.dart';
import 'package:salvando_vidas/ui/home/widgets/menu_card.dart';
import 'package:salvando_vidas/ui/home/widgets/metric_card.dart';

class FakeAlunoServiceHome extends Fake implements AlunoService {
  @override
  Future<List<Responsavel>> listarResponsaveis() async => [
        Responsavel(
          id: 10,
          nome: 'Responsavel Teste',
          cpf: '07481138096',
          contato: '11987654321',
          email: 'resp@teste.com',
          ativo: true,
        ),
      ];
}

class FakeHomeStore extends HomeStore {
  final AsyncValue<HomeState> fakeValue;
  FakeHomeStore(this.fakeValue);

  @override
  Future<HomeState> build() async {
    state = fakeValue;
    if (fakeValue.hasError) throw fakeValue.error!;
    return fakeValue.value!;
  }
}

Aluno _criarAluno(int id, String nome) {
  return Aluno(
    id: id,
    nome: nome,
    cpf: '52998224725',
    contato: '11999999999',
    contatoEmergencia: '11888888888',
    email: 'aluno@teste.com',
    nascimento: DateTime.now().add(const Duration(days: 1)),
    tipoSanguineo: TipoSanguineo.oPositivo,
    faixa: Faixa.branca,
    grau: 0,
    ativo: true,
    federado: false,
    dataEntrada: DateTime(2023, 1, 1),
    idResponsavel: 10,
  );
}

void main() {
  group('Home Widgets Tests', () {
    testWidgets('MetricCard com e sem subtitle em modo claro e escuro', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          home: const Scaffold(
            body: Column(
              children: [
                MetricCard(title: 'T1', value: '10', color: Colors.blue, subtitle: 'Sub1'),
                MetricCard(title: 'T2', value: '20', color: Colors.white),
              ],
            ),
          ),
        ),
      );

      expect(find.text('T1'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('Sub1'), findsOneWidget);
      expect(find.text('T2'), findsOneWidget);
    });

    testWidgets('MenuCard renderiza e responde a clique', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: MenuCard(
              title: 'Menu 1',
              subtitle: 'Sub Menu',
              color: Colors.green,
              icon: Icons.person,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Menu 1'), findsOneWidget);
      await tester.tap(find.text('Menu 1'));
      expect(tapped, isTrue);
    });
  });

  group('HomePage Tests', () {
    testWidgets('HomePage loading state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeStoreProvider.overrideWith(() => FakeHomeStore(const AsyncLoading())),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsWidgets);
    });

    testWidgets('HomePage error state', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeStoreProvider.overrideWith(() => FakeHomeStore(const AsyncError('Erro home', StackTrace.empty))),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      expect(find.text('Erro ao carregar os alunos'), findsOneWidget);
    });

    testWidgets('HomePage data state e dialogo de detalhes do aluno', (tester) async {
      final aluno = _criarAluno(1, 'Lucas Aniversariante');
      final homeState = HomeState(
        alunos: [aluno],
        alunosHome: [(aluno, 1, 5)],
        totalTurmas: 3,
        totalAlunos: 1,
        totalAtivos: 1,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            alunoServiceProvider.overrideWithValue(FakeAlunoServiceHome()),
            homeStoreProvider.overrideWith(() => FakeHomeStore(AsyncData(homeState))),
          ],
          child: const MaterialApp(home: HomePage()),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Lucas Aniversariante'), findsWidgets);

      await tester.tap(find.text('Lucas Aniversariante').last);
      await tester.pumpAndSettle();

      expect(find.text('Informações do Aluno'), findsOneWidget);
      expect(find.textContaining('Responsavel Teste', findRichText: true), findsOneWidget);

      await tester.tap(find.text('Fechar'));
      await tester.pumpAndSettle();
      expect(find.text('Informações do Aluno'), findsNothing);
    });
  });
}
