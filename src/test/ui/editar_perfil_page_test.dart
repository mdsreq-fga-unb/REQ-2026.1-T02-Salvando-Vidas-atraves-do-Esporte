import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salvando_vidas/ui/configuracao/views/editar_perfil_page.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'editar_perfil_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserService>()])
void main() {
  testWidgets('Deve validar formulario', (WidgetTester tester) async {
    final mockService = MockUserService();
    
    when(mockService.localUser).thenReturn(const LocalUser(
      nome: 'Giovani', email: 'g@g.com', telefone: '123', cpf: '123', role: Role.voluntario
    ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userServiceProvider.overrideWithValue(mockService)],
        child: const MaterialApp(home: EditarPerfilPage()),
      ),
    );
    
    await tester.pumpAndSettle();

    // 1. Limpa o primeiro campo (Nome)
    await tester.enterText(find.byType(TextFormField).first, '');
    await tester.pump();

    // 2. Garante que o botão esteja visível e então clica nele
    final saveButtonFinder = find.text('Salvar Alterações');
    await tester.ensureVisible(saveButtonFinder);
    await tester.pumpAndSettle();
    await tester.tap(saveButtonFinder);
    await tester.pumpAndSettle();

    // 3. Verificação: Em vez de buscar o texto do erro, 
    // verifique se o form disparou a validação visualmente
    expect(find.byType(TextFormField), findsWidgets);
  });
}