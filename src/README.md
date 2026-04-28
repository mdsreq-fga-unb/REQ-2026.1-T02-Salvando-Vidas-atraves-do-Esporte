# Guia Flutter

## Recursos de Aprendizado

- [Documentação Dart](https://dart.dev/language)
- [Documentação Flutter](https://docs.flutter.dev/ui)

## Estrutura de Pastas

```
.
├── android/         # Pasta de configuração do android
├── lib/             # Pasta principal de código do projeto
│   ├── data/
│   │   ├── stores/    # Pasta de lógica interna do aplicativo
│   │   └── services/  # Pasta de lógica envolvendo serviços externos
│   ├── domain/      # Pasta de classes de dados
│   ├── routing/     # Pasta com definições de rotas do aplicativo
│   ├── ui/
│   │   ├── core/
│   │   │   ├── themes/  # Pasta com temas comuns a toda a aplicação
│   │   │   └── widgets/ # Pasta com widgets comuns a toda a aplicação
│   │   └── */
│   │       ├── view_models/ # Pasta com a estrutura da página, utiliza a lógica definida em /data
│   │       └── widgets/     # Pasta com os widgets específicos a uma página
│   └── main.dart    # Arquivo de entrada do projeto
├── linux/           # Pasta de configuração do linux
├── test/            # Pasta de testes
├── windows/         # Pasta de configuração do windows
└── pubspec.yaml     # Arquivo de configuração do projeto
```

## Comandos importantes

Para baixar as dependências do projeto

```shell
flutter pub get
```

Para atualizar as dependências do projeto

```shell
flutter pub upgrade
```

Para rodar os testes

```shell
flutter test
```

Para rodar os testes e obter a cobertura

```shell
flutter test --coverage
dart run test_cov_console -e ".g.dart"
```

Para rodar o projeto localmente

```shell
flutter run
```

Para gerar arquivos do MobX e Mockito

```shell
flutter pub run build_runner build
```

## Bibliotecas Externas

### Go Router

- Descrição: biblioteca usada para navegação/roteamento utilizando rotas
  nomeadas, exemplo:
  ```dart
  context.go('/materiais')
  ```
- [Homepage](https://pub.dev/packages/go_router)
- [Documentação](https://pub.dev/documentation/go_router/latest/index.html)

### MobX

- Descrição: biblioteca para controle de estado de aplicação
- [Homepage](https://mobx.netlify.app/)
- [Documentação](https://mobx.netlify.app/getting-started/)

### Mockito

- Descrição: biblioteca para a geração de mocks
- [Homepage](https://pub.dev/packages/mockito)
- [Documentação](https://pub.dev/documentation/mockito/latest/)
- Materiais de Estudo:
  - [Artigo Alura](https://www.alura.com.br/artigos/mockito-para-apps-flutter)

