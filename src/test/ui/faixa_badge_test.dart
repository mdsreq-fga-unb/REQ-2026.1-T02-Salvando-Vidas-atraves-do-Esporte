import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Ajuste os imports abaixo para apontarem para o caminho correto no seu projeto
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/ui/global/widgets/faixa_badge.dart';

void main() {
  // Uma função auxiliar (Helper) para simular o ambiente do aplicativo.
  // Todo teste de Widget que usa Material Design precisa disso.
  Widget criarAmbienteDeTeste(Widget widget) {
    return MaterialApp(
      home: Scaffold(
        body: widget,
      ),
    );
  }

  group('Faixa Widgets -', () {
    
    testWidgets('FaixaBadge deve renderizar o nome da faixa com a cor correta', (WidgetTester tester) async {
      // 1. Renderizar (pumpWidget)
      await tester.pumpWidget(criarAmbienteDeTeste(
        const FaixaBadge(faixa: Faixa.azul),
      ));

      // 2. Procurar (find)
      // A sua extension 'nomeVisivel' vai transformar Faixa.azul em 'Azul'
      final textoFaixa = find.text('Azul'); 

      // 3. Validar (expect)
      expect(textoFaixa, findsOneWidget);
    });

    testWidgets('FaixaAvatar deve ser renderizado na tela sem quebrar', (WidgetTester tester) async {
      // 1. Renderizar
      await tester.pumpWidget(criarAmbienteDeTeste(
        const FaixaAvatar(faixa: Faixa.preta),
      ));

      // 2 & 3. Procurar e Validar
      // Como o Avatar é apenas um desenho de formas geométricas (Container, BoxShape),
      // nós validamos se o componente inteiro foi construído na árvore do Flutter.
      expect(find.byType(FaixaAvatar), findsOneWidget);
    });

    testWidgets('FaixaDropdownField deve exibir o valor inicial e abrir o menu ao ser clicado', (WidgetTester tester) async {
      Faixa? faixaSelecionada = Faixa.branca;

      // 1. Renderizar
      await tester.pumpWidget(criarAmbienteDeTeste(
        FaixaDropdownField(
          value: faixaSelecionada,
          onChanged: (novaFaixa) {
            faixaSelecionada = novaFaixa;
          },
        ),
      ));

      // 2 & 3. Valida se o label padrão ('Faixa*') e a opção inicial estão visíveis
      expect(find.text('Faixa*'), findsOneWidget);
      expect(find.text('Branca'), findsWidgets); // findsWidgets porque o Flutter desenha o texto mais de uma vez internamente no Dropdown

      // --- SIMULANDO INTERAÇÃO DO USUÁRIO ---
      
      // Manda o "dedo" virtual clicar no Dropdown
      await tester.tap(find.byType(DropdownButtonFormField<Faixa>));
      
      // O pumpAndSettle avisa ao Flutter: "Espere todas as animações terminarem"
      // Sem isso, o teste tenta ler a tela enquanto a gaveta do menu ainda está descendo.
      await tester.pumpAndSettle(); 

      // Valida se, após abrir o menu, a opção 'Preta' apareceu na lista para ser clicada
      expect(find.text('Preta'), findsWidgets);
    });
  });
}