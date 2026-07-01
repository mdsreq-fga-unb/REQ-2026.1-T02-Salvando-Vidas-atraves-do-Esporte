import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/views/pesquisa_alunos_page.dart';
import 'package:salvando_vidas/ui/Pesquisar-editar-dados-Aluno/widgets/aluno_expandable_card.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/data/stores/pesquisa_aluno/pesquisa_aluno_store.dart';

// ------------------------------------------------------------------
// 1. DADOS FALSOS (MOCKS)
// ------------------------------------------------------------------
final alunoAtivoMock = Aluno(
  id: 1,
  nome: 'Lucas Oliveira',
  cpf: '12345678900',
  nascimento: DateTime(2000, 1, 1),
  email: 'lucas@email.com',
  faixa: Faixa.branca,
  grau: 1,
  tipoSanguineo: TipoSanguineo.aPositivo,
  dataEntrada: DateTime.now(),
  ativo: true, // ALUNO ATIVO
  federado: false,
  pMedica1: false, pMedica2: false, pMedica3: false, pMedica4: false, pMedica5: false,
  idResponsavel: 1,
);

final alunoInativoMock = Aluno(
  id: 2,
  nome: 'Pedro Inativo',
  cpf: '09876543211',
  nascimento: DateTime(2005, 1, 1),
  email: 'pedro@email.com',
  faixa: Faixa.cinza,
  grau: 2,
  tipoSanguineo: TipoSanguineo.oPositivo,
  dataEntrada: DateTime.now(),
  ativo: false, // ALUNO INATIVO
  federado: false,
  pMedica1: false, pMedica2: false, pMedica3: false, pMedica4: false, pMedica5: false,
  idResponsavel: 1,
);

final responsavelMock = Responsavel(
  id: 1,
  nome: 'João Responsável',
  cpf: '00011122233',
  contato: '61999999999',
  email: 'joao@email.com',
  ativo: true,
);

// ------------------------------------------------------------------
// 2. PROVEDOR "DUBLÊ" (FAKE NOTIFIER)
// ------------------------------------------------------------------
// Estendemos a store original para controlar exatamente o que a tela vai receber
class FakePesquisaAlunoNotifier extends PesquisaAluno {
  @override
  Future<PesquisaAlunoState> build() async {
    // Retorna a tela já carregada com 1 aluno ativo e 1 inativo escondido
    return PesquisaAlunoState(
      alunos: [alunoAtivoMock, alunoInativoMock],
      alunosFiltrados: [alunoAtivoMock], // Inicialmente só mostra o ativo
      responsaveis: {1: responsavelMock},
      mostrarInativos: false,
    );
  }

  @override
  void toggleMostrarInativos() {
    final data = state.value!;
    final novoValor = !data.mostrarInativos;
    
    // Atualiza o estado simulando a lógica real do aplicativo
    state = AsyncValue.data(data.copyWith(
      mostrarInativos: novoValor,
      alunosFiltrados: novoValor 
          ? [alunoAtivoMock, alunoInativoMock] 
          : [alunoAtivoMock],
    ));
  }
}

// ------------------------------------------------------------------
// 3. SUÍTE DE TESTES
// ------------------------------------------------------------------
void main() {
  group('PesquisaAlunosPage - Testes de Tela (Frente A)', () {
    
    // O NOSSO PRIMEIRO TESTE (MANTIDO)
    testWidgets('Deve renderizar a estrutura base e exibir erro/vazio sem internet', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(
        child: MaterialApp(home: PesquisaAlunosPage()),
      ));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    // O NOSSO NOVO TESTE: O CAMINHO FELIZ
    testWidgets('Deve exibir a lista de alunos e interagir com o switch de inativos', (WidgetTester tester) async {
      // Usamos a propriedade "overrides" do Riverpod para trocar o provedor real pelo nosso Dublê
      await tester.pumpWidget(ProviderScope(
        overrides: [
          pesquisaAlunoProvider.overrideWith(() => FakePesquisaAlunoNotifier()),
        ],
        child: const MaterialApp(home: PesquisaAlunosPage()),
      ));

      // Espera a tela terminar de desenhar o nosso dublê
      await tester.pumpAndSettle();

      // VALIDAÇÃO 1: O aluno ativo deve estar na tela
      expect(find.byType(AlunoExpandableCard), findsOneWidget);
      expect(find.text('Lucas Oliveira'), findsOneWidget);
      
      // O aluno inativo NÃO deve estar visível ainda
      expect(find.text('Pedro Inativo'), findsNothing);

      // --- INTERAÇÃO DO USUÁRIO ---
      // Simulamos o clique no botão "Mostrar inativos"
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle(); // Aguarda a animação da lista

      // VALIDAÇÃO 2: Agora devem existir 2 cartões na tela (Ativo + Inativo)
      expect(find.byType(AlunoExpandableCard), findsNWidgets(2));
      expect(find.text('Pedro Inativo'), findsOneWidget);
    });
    
  });
}