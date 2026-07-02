import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/configuracao/views/editar_perfil_page.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

// 1. Fake do UserService com ID para evitar o Null Check Error
class FakeUserService implements UserService {
  @override
  LocalUser? get localUser => const LocalUser(
    id: '1234-uuid-teste', // <--- FALTAVA ISSO PARA A TELA NÃO QUEBRAR
    nome: 'Giovani',
    email: 'g@g.com',
    telefone: '123',
    cpf: '123',
    role: Role.voluntario,
    funcao: 'Professor',
    faixa: Faixa.preta,
  );

  @override
  Future<bool> isLoggedIn() async => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

// 2. Fake do Logger
class FakeLogger extends Logger {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('Deve exibir erro de validacao ao tentar salvar com nome vazio', (
    WidgetTester tester,
  ) async {
    tester.binding.window.physicalSizeTestValue = const Size(1080, 2340);
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userServiceProvider.overrideWithValue(FakeUserService()),
          loggerProvider.overrideWithValue(FakeLogger()),
        ],
        child: const MaterialApp(home: EditarPerfilPage()),
      ),
    );

    await tester.pumpAndSettle();

    // Procura qualquer componente da tela que permita edição de texto
    final camposInput = find.byType(EditableText);
    expect(
      camposInput,
      findsWidgets,
      reason: 'A tela não renderizou os campos.',
    );

    // Apaga o campo de nome
    await tester.enterText(camposInput.first, '');
    await tester.pumpAndSettle();

    // Toca no botão de salvar
    await tester.tap(find.text('Salvar Alterações'));
    await tester.pumpAndSettle();

    // Confirma se o validador foi acionado
    expect(find.text('Informe seu nome'), findsOneWidget);
  });
}
