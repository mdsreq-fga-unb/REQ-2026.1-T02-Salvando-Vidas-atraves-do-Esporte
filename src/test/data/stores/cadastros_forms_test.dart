import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/data/stores/cadastro_voluntario/cadastro_voluntario_form.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

void main() {
  group('CadastroVoluntario Store Tests', () {
    test('validações, updates e getter voluntario', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cadastroVoluntarioProvider.notifier);
      expect(container.read(cadastroVoluntarioProvider).podeCadastrar, isFalse);

      notifier.updateNome('Carlos Voluntario');
      notifier.updateEmail('carlos@teste.com');
      notifier.updateTelefone('11987654321');
      notifier.updateSenha('senha123');
      notifier.updateCpf('52998224725');
      notifier.updateFuncao('Instrutor');
      notifier.updateFaixa(Faixa.preta);

      final state = container.read(cadastroVoluntarioProvider);
      expect(state.podeCadastrar, isTrue);
      expect(state.voluntario.nome, 'Carlos Voluntario');
      expect(state.voluntario.faixa, Faixa.preta);

      // Testar erros com dirty
      notifier.updateEmail('invalido');
      expect(container.read(cadastroVoluntarioProvider).emailError, isNotNull);
      expect(container.read(cadastroVoluntarioProvider).podeCadastrar, isFalse);
    });
  });

  group('CadastroAluno Store Tests', () {
    test('validações, updates e getters aluno e responsavel', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(cadastroAlunoProvider.notifier);
      expect(container.read(cadastroAlunoProvider).estaValido, isFalse);

      final hoje = DateTime.now();
      final nascimentoAdulto = DateTime(hoje.year - 20, 1, 1);

      notifier.updateNome('Aluno Teste');
      notifier.updateCPF('52998224725');
      notifier.updateContato('11987654321');
      notifier.updateContatoEmergencia('11987654322');
      notifier.updateEmail('aluno@teste.com');
      notifier.updateNascimento(nascimentoAdulto);
      notifier.updateTipoSanguineo(TipoSanguineo.oPositivo);
      notifier.updateFaixa(Faixa.branca);
      notifier.updateIdFicha('100');

      final state = container.read(cadastroAlunoProvider);
      expect(state.estaValido, isTrue);
      expect(state.idade, 20);
      expect(state.temResponsavel, isTrue); // é adulto
      expect(state.aluno.nome, 'Aluno Teste');
      expect(state.responsavel.nome, '');

      // Testar aluno menor de idade
      final nascimentoMenor = DateTime(hoje.year - 10, 1, 1);
      notifier.updateNascimento(nascimentoMenor);
      expect(container.read(cadastroAlunoProvider).temResponsavel, isFalse);

      notifier.updateNomeResponsavel('Mae do Aluno');
      notifier.updateCPFResponsavel('52998224725');
      notifier.updateContatoResponsavel('11987654323');
      notifier.updateEmailResponsavel('mae@teste.com');

      final stateMenor = container.read(cadastroAlunoProvider);
      expect(stateMenor.temResponsavel, isTrue);
      expect(stateMenor.responsavel.nome, 'Mae do Aluno');
    });
  });
}
