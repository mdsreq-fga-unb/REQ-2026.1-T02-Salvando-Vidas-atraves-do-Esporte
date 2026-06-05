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
│   │       ├── views/ # Pasta com a estrutura da página, utiliza a lógica definida em /data
│   │       └── widgets/     # Pasta com os widgets específicos a uma página
│   └── main.dart    # Arquivo de entrada do projeto
├── linux/           # Pasta de configuração do linux
├── test/            # Pasta de testes
├── web/             # Pasta de configuração do site
├── windows/         # Pasta de configuração do windows
└── pubspec.yaml     # Arquivo de configuração do projeto
```

## Comandos importantes

Para baixar as dependências do projeto

```sh
flutter pub get
```

Para atualizar as dependências do projeto

```sh
flutter pub upgrade
```

Para rodar os testes

```sh
flutter test
```

Para rodar os testes e obter a cobertura

```sh
flutter test --coverage
dart run test_cov_console -e ".g.dart"
```

Para rodar o projeto localmente

```sh
flutter run
```

Para gerar arquivos do MobX e Mockito

```sh
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

### Flutter Local Notifications

- Descrição: biblioteca para mostrar notificações
- [Homepage](https://pub.dev/packages/flutter_local_notifications)
- [Documentação](https://pub.dev/documentation/flutter_local_notifications/latest/)

### mock_supabase_http_client

- Descrição: Mock do cliente Supabase
- [Homepage](https://pub.dev/packages/mock_supabase_http_client)
- [Documentação](https://pub.dev/documentation/mock_supabase_http_client/latest/)

### image_picker

- Descrição: Widget para pegar imagens do sistema ou cámera, usado para lidar
  com as fotos dos alunos no cadastro.
- [Homepage](https://pub.dev/packages/image_picker)
- [Documentação](https://pub.dev/documentation/image_picker/latest/)
