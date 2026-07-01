import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/etapa_dados_basicos.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/etapa_dados_medicos.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/etapa_dados_responsavel.dart';

void main() {
  group('Etapas Cadastro Aluno Tests', () {
    Widget createTestApp(Widget child, {ThemeMode mode = ThemeMode.light}) {
      return ProviderScope(
        child: MaterialApp(
          themeMode: mode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: SingleChildScrollView(child: child),
          ),
        ),
      );
    }

    testWidgets('EtapaDadosBasicos renderiza campos de dados básicos e responde a interações (Light & Dark)', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(createTestApp(EtapaDadosBasicos(formKey: formKey)));

      expect(find.textContaining('Nome', findRichText: true), findsAtLeastNWidgets(1));
      expect(find.textContaining('Apelido', findRichText: true), findsOneWidget);

      await tester.pumpWidget(createTestApp(
        EtapaDadosBasicos(formKey: formKey),
        mode: ThemeMode.dark,
      ));
      expect(find.textContaining('Nome', findRichText: true), findsAtLeastNWidgets(1));
    });

    testWidgets('EtapaDadosMedicos renderiza perguntas médicas e checkbox de termo (Light & Dark)', (tester) async {
      final formKey = GlobalKey<FormState>();
      var termo = false;
      await tester.pumpWidget(createTestApp(
        EtapaDadosMedicos(
          formKey: formKey,
          termoAceito: termo,
          onTermoChanged: (val) => termo = val ?? false,
        ),
      ));

      expect(find.textContaining('condição de saúde crônica'), findsOneWidget);
      expect(find.textContaining('O aluno (ou responsável legal) declarou ter compreendido'), findsOneWidget);

      await tester.ensureVisible(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Checkbox));
      expect(termo, isTrue);

      await tester.pumpWidget(createTestApp(
        EtapaDadosMedicos(
          formKey: formKey,
          termoAceito: true,
          onTermoChanged: (val) {},
        ),
        mode: ThemeMode.dark,
      ));
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('EtapaDadosResponsavel renderiza campos do responsável (Light & Dark)', (tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(createTestApp(EtapaDadosResponsavel(formKey: formKey)));

      expect(find.textContaining('Nome do Responsável', findRichText: true), findsOneWidget);
      expect(find.textContaining('CPF do Responsável', findRichText: true), findsOneWidget);

      await tester.pumpWidget(createTestApp(
        EtapaDadosResponsavel(formKey: formKey),
        mode: ThemeMode.dark,
      ));
      expect(find.textContaining('Nome do Responsável', findRichText: true), findsOneWidget);
    });
  });
}
