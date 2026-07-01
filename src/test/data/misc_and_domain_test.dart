import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/services/global/global_service.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/turma/core/turma_model.dart';

void main() {
  group('Misc & Domain Extras Tests', () {
    test('LocalUser serialization mappers', () {
      const user = LocalUser(
        id: 'u-1',
        role: Role.admin,
        nome: 'Admin',
        telefone: '11999999999',
        cpf: '52998224725',
        email: 'admin@t.com',
        funcao: 'Diretor',
        faixa: Faixa.preta,
      );

      final map = user.toMap();
      final fromMap = LocalUser.fromMap(map);
      expect(fromMap.nome, 'Admin');

      final json = user.toJson();
      final fromJson = LocalUser.fromJson(json);
      expect(fromJson.email, 'admin@t.com');
    });

    test('Responsavel serialization mappers', () {
      final resp = Responsavel(
        id: 1,
        nome: 'Resp',
        cpf: '52998224725',
        contato: '11999999999',
        email: 'r@t.com',
        ativo: true,
      );

      final map = resp.toMap();
      final fromMap = Responsavel.fromMap(map);
      expect(fromMap.nome, 'Resp');

      final json = resp.toJson();
      final fromJson = Responsavel.fromJson(json);
      expect(fromJson.email, 'r@t.com');
    });

    test('Global Service Providers', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final log = container.read(loggerProvider);
      expect(log, isNotNull);

      expect(supabaseClientProvider, isNotNull);
    });

    test('TurmaModel mock verification', () {
      expect(turmasMock.length, 2);
      expect(turmasMock.first.nome, 'Turma Infantil');
      expect(turmasMock.first.alunos?.length, 6);
    });

    test('Colors constants verification', () {
      expect(AppColors.royalAzure, isNotNull);
      expect(PaletaDeCores.primaryCyan, isNotNull);
    });
  });
}
