# Guia Flutter do Projeto

## Como o Flutter funciona

O Flutter é um framework para criar interfaces com uma única base de código.
No projeto, a aplicação começa em [lib/main.dart](lib/main.dart), onde o widget
`runApp` inicializa a árvore principal e injeta dependências globais.

O Flutter organiza a interface como uma árvore de widgets. Cada parte da tela,
como um botão, um formulário ou uma página inteira, é um widget. Quando o
estado muda, o Flutter reconstrói apenas a parte necessária da interface.

No projeto, a navegação é controlada pelo arquivo [lib/routing/router.dart](lib/routing/router.dart)
e pelas rotas definidas em [lib/routing/routes.dart](lib/routing/routes.dart).
Assim, cada tela fica desacoplada e pode ser adicionada sem mexer em toda a
aplicação.

## Estrutura de uma página

Uma página normalmente fica dentro de `lib/ui/<area>/` e costuma seguir esta
organização:

- `view_models/`: concentra a lógica da página e a ligação com os dados.
- `widgets/`: guarda componentes específicos daquela tela.
- Arquivo principal da tela: monta a interface e conecta os widgets.

Exemplo prático:

- `lib/ui/auth/login_page.dart`: tela de login.
- `lib/ui/home/view_models/home_view_models.dart`: página inicial de exemplo.

## Como criar uma nova página

1. Crie uma nova pasta dentro de `lib/ui/` para o módulo da tela.
2. Adicione um arquivo principal da página, por exemplo `perfil_page.dart`.
3. Se a tela tiver componentes reaproveitáveis, crie também uma pasta `widgets/`.
4. Se a tela precisar de lógica separada, crie uma pasta `view_models/`.
5. Registre a nova rota em [lib/routing/routes.dart](lib/routing/routes.dart).
6. Adicione a página no roteador em [lib/routing/router.dart](lib/routing/router.dart).

Exemplo de rota:

```dart
abstract final class Routes {
  static const login = '/';
  static const perfil = '/perfil';
}
```

Exemplo de registro no roteador:

```dart
GoRoute(
  path: Routes.perfil,
  builder: (context, state) => const PerfilPage(),
)
```

## Como adicionar funcionalidades

Quando a nova funcionalidade for visual e isolada, você pode começar criando
um widget novo dentro da tela. Quando a funcionalidade depender de dados,
estado ou integração com serviços, o ideal é separar a lógica da interface.

Fluxo recomendado:

1. Defina o que a funcionalidade precisa receber e exibir.
2. Crie um widget reutilizável se a parte visual puder ser reaproveitada.
3. Coloque regras de negócio, validações e chamadas externas no lugar certo:
   `data/` para acesso a serviços, `domain/` para modelos e `view_models/` para
   a lógica da tela.
4. Exponha o resultado na interface usando `Provider`, `MobX` ou outra solução
   já usada no projeto.
5. Se a funcionalidade gerar uma nova tela, registre uma nova rota.

Exemplos de funcionalidades que seguem esse padrão:

- Validação de login.
- Cadastro de aluno.
- Listagem de turmas.
- Integração com Supabase.

## Boas práticas no projeto

- Mantenha o código da interface separado da lógica sempre que possível.
- Reutilize widgets quando a mesma estrutura aparecer em mais de uma tela.
- Registre rotas novas no arquivo de rotas, em vez de navegar com strings soltas.
- Prefira componentes pequenos e fáceis de testar.
- Atualize a documentação quando uma nova tela ou fluxo importante for criado.

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