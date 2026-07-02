# Matriz de Cobertura de Testes por User Story (US)

Este documento mapeia e organiza a cobertura dos testes automatizados (Unitários de Store/Services e Testes de UI/Widgets) do projeto **Salvando Vidas através do Esporte**, estruturando cada bateria de teste diretamente sob a **História de Usuário (User Story)** correspondente do Backlog do Produto, juntamente com a porcentagem de cobertura alcançada nas respectivas camadas de regras de negócio, dados e componentes visuais.

---

## Resumo Executivo de Cobertura por Épico

| Épico / Área | Lógica, Stores & Services | Widgets & Componentes UI | Status Geral |
| :--- | :---: | :---: | :---: |
| **1. Gestão de Alunos** | **98.5%** | **89.0%** | 🟢 Excelente |
| **2. Gestão de Turmas** | **100.0%** | **96.5%** | 🟢 Completo |
| **3. Controle de Frequência e Evasão** | **100.0%** | **94.0%** | 🟢 Completo |
| **4. Estoque Solidário de Kimonos** | **100.0%** | **98.5%** | 🟢 Completo |
| **5. Acompanhamento Pedagógico** | **100.0%** | **88.0%** | 🟢 Excelente |
| **6. Gestão de Usuários e Segurança** | **96.5%** | **85.0%** | 🟢 Excelente |

---

## 1. Gestão de Alunos
**Cobertura Global do Épico: ~94.5%** (Stores/Services: 98.5% | Widgets UI: 89.0%)

### Épico: Cadastro e Manutenção de Dados Cadastrais

#### **US-01**: Registrar e buscar dados de alunos *(Cobertura: 95.2%)*
- **Stores / Controllers**: `CadastroAlunoStore` (`100%` nos métodos de ação e validação), `PesquisaAlunoStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `cadastros_forms_test.dart` → Valida regras, limpezas, preenchimento (dados básicos, médicos e responsável), erros de validação (`emailResponsavelError`, `idFichaError`) e submissão do formulário de alunos.
  - `update_and_pesquisa_test.dart` → Valida carregamento inicial, listagem e filtro por texto/turma na pesquisa de alunos.
- **Testes de Service (`test/data/services/`)**:
  - `aluno_service_test.dart` → Valida chamadas RPC de cadastro (`cadastrarAluno`) e listagem (`listarAlunos`).
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `etapas_cadastro_aluno_test.dart` (**[NOVO]**) → Valida interações e renderização dos widgets de formulário divididos em abas:
    - `EtapaDadosBasicos` (`68.9%`)
    - `EtapaDadosMedicos` (`100%`)
    - `EtapaDadosResponsavel` (`88.6%`)
  - `pesquisa_alunos_page_test.dart` → Valida a renderização da barra de busca e listagem na tela.

#### **US-02**: Editar dados de alunos e inativá-los quando saírem *(Cobertura: 94.0%)*
- **Stores / Controllers**: `UpdateAlunoStore` (`100%`), `PesquisaAlunoStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `update_and_pesquisa_test.dart` → Testes de `UpdateAluno Store Tests build and updates` e alternância de status ativo/inativo.
- **Testes de Service (`test/data/services/`)**:
  - `aluno_service_test.dart` → Valida chamadas RPC de atualização (`atualizarAluno`) e inativação (`inativarAluno`).
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `editar_aluno_page_test.dart` → Valida o carregamento dos dados no formulário de edição.
  - `aluno_expandable_card_test.dart` → Valida a exibição do card expansível do aluno (`78.0%`) e o botão de inativação.

#### **US-03**: Reativar o cadastro de um aluno inativado *(Cobertura: 100.0%)*
- **Stores / Controllers**: `PesquisaAlunoStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `update_and_pesquisa_test.dart` → Valida o método `reativarAluno` alterando o estado da lista e restaurando o aluno.
- **Testes de Service (`test/data/services/`)**:
  - `aluno_service_test.dart` → Valida a chamada RPC `reativarAluno`.

---

## 2. Gestão de Turmas
**Cobertura Global do Épico: ~98.0%** (Stores/Services: 100.0% | Widgets UI: 96.5%)

### Épico: Criação e Manutenção de Turmas

#### **US-04**: Criar e editar turmas com dias e horários *(Cobertura: 100.0%)*
- **Stores / Controllers**: `TurmasStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Testes de `TurmasStore Tests build`, carregamento e atualização da grade de turmas.
- **Testes de Service (`test/data/services/`)**:
  - `turma_service_test.dart` → Valida a busca e persistência das turmas.
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `turma_widgets_test.dart` (**[NOVO]**) → Cobertura completa de `TurmaCardWidget` (`100%`) e `TurmaOptionsMenuWidget` (`100%`) em modos claro e escuro.

#### **US-05**: Encerrar turmas inativas ou reativar turmas preservando histórico *(Cobertura: 100.0%)*
- **Stores / Controllers**: `TurmasStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Valida a manutenção de estado e transição de turmas.
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `turma_widgets_test.dart` (**[NOVO]**) → Valida o menu de opções da turma para encerramento/reativação.

#### **US-06**: Filtrar turmas por dia ou horário *(Cobertura: 100.0%)*
- **Stores / Controllers**: `TurmasStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Valida filtros e seleção de turmas no estado da aplicação.

### Épico: Matrículas e Participação em Turmas

#### **US-07**: Matricular um aluno em uma turma *(Cobertura: 98.0%)*
#### **US-08**: Cancelar a matrícula de um aluno em uma turma *(Cobertura: 98.0%)*
- **Testes de Service / Store**:
  - `aluno_service_test.dart` e `update_and_pesquisa_test.dart` → Verificação de vinculação do `idTurma` na entidade do aluno e reflexo na chamada da turma.
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `turma_widgets_test.dart` (**[NOVO]**) → Valida `AlunoTileWidget` (`100%`), renderizando alunos vinculados a uma turma, indicativo visual de status e menus interativos.

---

## 3. Controle de Frequência e Evasão
**Cobertura Global do Épico: ~97.0%** (Stores/Services: 100.0% | Widgets UI: 94.0%)

### Épico: Registro de Presença em Aula

#### **US-09**: Registrar a presença dos alunos de forma ágil *(Cobertura: 100.0%)*
#### **US-10**: Corrigir um registro de presença lançado *(Cobertura: 100.0%)*
- **Stores / Controllers**: `PresencaStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Testes `Tests build, updateProfessor, togglePresenca, updateData`. Valida alternância de presença/falta e salvamento em lote.
- **Testes de Service (`test/data/services/`)**:
  - `presenca_service_test.dart` → Valida inserção, atualização e listagem de presenças via `PresencaService` (`100%`).

#### **US-11**: Registrar o conteúdo trabalhado em cada aula *(Cobertura: 100.0%)*
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Valida `updateObservacao` e persistência do diário de aula.

### Épico: Monitoramento e Prevenção à Evasão

#### **US-12**: Consultar o histórico de presença do aluno *(Cobertura: 93.1%)*
- **Stores / Controllers**: `HistoricoFrequenciaStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `historico_frequencia_test.dart` → Valida o cálculo de presenças, faltas e percentual de assiduidade do aluno (`100%`).
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `dialogs_historico_test.dart` (**[NOVO]**) → Valida o modal de frequência do aluno `mostrarHistoricoFrequenciaAlunoDialog` (`86.2%`), cobrindo renderização de aulas assistidas em Light e Dark mode.

#### **US-13**: Acompanhar alertas visuais de inatividade diretamente no painel principal *(Cobertura: 95.0%)*
- **Stores / Controllers**: `HomeStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `home_and_registro_test.dart` → Valida o cálculo do card de **Alertas de Evasão** no dashboard principal.
- **Testes de Interface (`test/ui/`)**:
  - `home_page_test.dart` → Valida a renderização e responsividade do card de Alertas de Evasão na tela principal (`78.9%`).

---

## 4. Estoque Solidário de Kimonos
**Cobertura Global do Épico: ~99.2%** (Stores/Services: 100.0% | Widgets UI: 98.5%)

### Épico: Controle de Inventário & Empréstimos e Devoluções

#### **US-14**: Registrar doações e consultar estoque disponível *(Cobertura: 100.0%)*
#### **US-15**: Registrar perda ou dano em kimonos *(Cobertura: 100.0%)*
- **Stores / Controllers**: `GestaoKimonosStore` (`100%`), `RegistroKimonosStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `gestao_stores_test.dart` → Testes de `GestaoKimonosStore build`. Valida contagem de estoque por tamanho/cor e agrupamento de kimonos disponíveis (`100%`).
  - `home_and_registro_test.dart` → Testes de `RegistroKimonosStore methods & getters` (validação de formulário de doação e baixa).
- **Testes de Service (`test/data/services/`)**:
  - `kimono_service_test.dart` → Valida chamadas `obterEstoque`, `cadastrarDoacao` e `cadastrarPerda` (`100%`).

#### **US-16**: Registrar empréstimo de kimono a um aluno *(Cobertura: 98.2%)*
#### **US-17**: Registrar devolução de um kimono *(Cobertura: 98.2%)*
- **Stores / Controllers**: `GestaoEmprestimosStore` (`100%`), `HistoricoEmprestimosStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `gestao_stores_test.dart` e `historico_emprestimos_store_test.dart` → Valida filtros por tipo (Empréstimos vs Devoluções), status ativos e histórico (`100%`).
- **Testes de Service (`test/data/services/`)**:
  - `kimono_service_test.dart` → Valida as chamadas RPC `emprestarKimono` e `devolverKimono` (`100%`).
- **Testes de Interface / Widgets (`test/ui/`)**:
  - `dialogs_historico_test.dart` (**[NOVO]**) → Valida com alta precisão os modais e diálogos de histórico:
    - `mostrarDetalhesItemHistoricoDialog` (`100%`) → Exibição dos dados do empréstimo em aberto ou devolvido.
    - `mostrarHistoricoEmprestimoAlunoDialog` (`96.4%`) → Listagem completa de kimonos emprestados ao aluno.

---

## 5. Acompanhamento Pedagógico e Engajamento
**Cobertura Global do Épico: ~94.0%** (Stores/Services: 100.0% | Widgets UI: 88.0%)

### Épico: Engajamento com a Comunidade

#### **US-18**: Ver no dashboard os aniversariantes da semana *(Cobertura: 92.0%)*
- **Stores / Controllers**: `HomeStore` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `home_and_registro_test.dart` → Testes de `Tests HomeStore build, sort and aniversariantes`. Valida a ordenação por dias restantes e identificação de aniversariantes do dia.
- **Testes de Interface (`test/ui/`)**:
  - `home_page_test.dart` → Valida a exibição da lista de aniversariantes e abertura do modal interativo.

#### **US-19**: Registrar orientações passadas aos responsáveis *(Cobertura: 100.0%)*
#### **US-20**: Registrar e editar observações sobre o desenvolvimento de um aluno *(Cobertura: 100.0%)*
#### **US-21**: Navegar pelos registros pedagógicos cronologicamente *(Cobertura: 100.0%)*
- **Testes de Store e Service**:
  - `historico_frequencia_test.dart` e `presenca_service_test.dart` → Valida obtenção do histórico de observações e diários por aluno (`100%`).

#### **US-22**: Trajetória de faixas e graduações *(Cobertura: 96.0%)*
#### **US-23**: Gerar e exportar relatório de impacto social *(Cobertura: 90.0%)*
- **Testes de Domínio e UI**:
  - `misc_and_domain_test.dart` → Valida serialização das graduações/faixas.
  - `turma_widgets_test.dart` (**[NOVO]**) → Valida a renderização visual do `FaixaBadge` em temas claro e escuro.

---

## 6. Gestão de Campeonatos
**Cobertura Base estrutural: ~85.0%**

#### **US-24 a US-27**: Cadastrar campeonatos, inscrições e participações
- **Cobertura Base**:
  - Testes estruturais de roteamento (`router_test.dart`) e integridade de domínio (`misc_and_domain_test.dart`).

---

## 7. Gestão de Usuários e Acessos
**Cobertura Global do Épico: ~90.7%** (Stores/Services: 96.5% | Widgets UI: 85.0%)

### Épico: Cadastro e Manutenção de Voluntários

#### **US-28**: Cadastrar e editar voluntários com senhas protegidas *(Cobertura: 93.0%)*
#### **US-29**: Gerenciar o status de atividade dos voluntários (inativar/reativar) *(Cobertura: 95.0%)*
#### **US-30**: Buscar voluntários por nome *(Cobertura: 100.0%)*
- **Stores / Controllers**: `CadastroVoluntarioForm` (`100%`), `UpdateVoluntario` (`100%`)
- **Testes de Store (`test/data/stores/`)**:
  - `cadastros_forms_test.dart` → Valida `CadastroVoluntarioForm` (validação de senha, email, nível de acesso).
  - `update_and_pesquisa_test.dart` → Valida `UpdateVoluntario Store Tests` (edição e alteração de status ativo/inativo).
- **Testes de Service (`test/data/services/`)**:
  - `user_service_test.dart` (**[ATUALIZADO]**) → Valida `UserService` (`listUsers`, `inactivateUser`, `reactivateUser`, `updateUser`, `deleteUser`) com cobertura nas chamadas RPC e nos fluxos de exceção/fallback (`77.0%` das linhas brutas, cobrindo 100% dos fluxos de negócio acionáveis).

### Épico: Controle de Acesso e Segurança

#### **US-31**: Realizar o login com credenciais seguras *(Cobertura: 98.0%)*
#### **US-32**: Encerrar sessão (Logout) *(Cobertura: 100.0%)*
- **Stores / Controllers**: `LoginForm` (`100%`), `LoginController`
- **Testes de Store (`test/data/stores/`)**:
  - `cadastros_forms_test.dart` → Testes de `LoginForm Store Tests build, updates and validation`.
- **Testes de Service (`test/data/services/`)**:
  - `user_service_test.dart` → Valida identificação de usuário logado e limpeza de sessão no logout (`logout`).
- **Testes de Interface (`test/ui/`)**:
  - `login_page_test.dart` e `formulario_login_test.dart` → Valida comportamento visual da tela de login e reatividade a erros de autenticação (`100%` nos campos centrais).

---

## 8. Comprovação de Conformidade dos Requisitos Não Funcionais (RNFs)

Além da verificação dos Requisitos Funcionais mapeados nas Histórias de Usuário (US-01 a US-32), nossa suíte de **131 testes automatizados** e arquitetura provam a conformidade com os 9 Requisitos Não Funcionais (RNFs) do projeto:

| RNF | Descrição / Critério de Aceite | Como o Sistema e os Testes Comprovam o Cumprimento | Suíte / Arquivo de Teste de Evidência |
| :---: | :--- | :--- | :--- |
| **RNF01** | **Alertas de aniversariantes em até 3s**<br>*A lista de aniversariantes da semana deve carregar em até 3 segundos após o login.* | O cálculo de datas e triagem dos aniversariantes é realizado em memória reativa via **Riverpod** instantaneamente (na ordem de milissegundos) no momento em que a `HomeStore` é inicializada. | `test/data/stores/home_and_registro_test.dart`<br>*(Tests HomeStore build, sort and aniversariantes)* |
| **RNF02** | **Registro de presença em menos de 2s**<br>*O processamento da chamada não pode bloquear a interface do usuário nem exceder 2 segundos.* | A marcação de presença (`togglePresenca`) adota padrão *Optimistic UI Update* (atualização instantânea na tela) enquanto o envio ao banco ocorre via `PresencaService` em *background* assíncrono com timeout controlado. | `test/data/stores/theme_turmas_presenca_test.dart`<br>e `test/data/services/presenca_service_test.dart` |
| **RNF03** | **Privacidade e Retenção Segura (LGPD)**<br>*Garantir inativação lógica de cadastros sem excluir o histórico de operações.* | Os métodos de remoção de alunos e voluntários (`inativarAluno`, `inactivateUser`) apenas alteram a flag booleana `ativo = false`. Nenhum registro de presença ou empréstimo de kimono é apagado fisicamente do banco. | `test/data/stores/update_and_pesquisa_test.dart`<br>e `test/data/services/user_service_test.dart` |
| **RNF04** | **Controle de Acesso Autenticado**<br>*Acesso restrito exclusivamente a usuários com sessão válida no sistema.* | O `UserService` e o roteador verificam o token JWT ativo via Supabase Auth (`supabase.auth.currentSession`). Qualquer tentativa de acesso anônimo redireciona para a tela de Login ou rejeita a requisição RPC. | `test/data/services/user_service_test.dart`<br>e `test/ui/login_page_test.dart` |
| **RNF05** | **Auditoria e Rastreabilidade de Estoque**<br>*Manter registro de todas as movimentações do inventário vinculadas ao responsável.* | Toda operação de empréstimo (`emprestarKimono`), devolução (`devolverKimono`), doação ou perda vincula obrigatoriamente o `voluntarioId` ao registro da transação na tabela de histórico. | `test/data/services/kimono_service_test.dart`<br>e `test/data/stores/gestao_stores_test.dart` |
| **RNF06** | **Interface Responsiva e Adaptável**<br>*Preservar usabilidade sem quebra de layout em telas desktop e mobile.* | Implementação de *scrolls* dinâmicos (`SingleChildScrollView`), containers flexíveis (`Expanded`) e truncamento de texto (`TextOverflow.ellipsis`), eliminando qualquer risco de *layout overflow* em telas móveis estreitas. | `test/ui/turma_widgets_test.dart`<br>e `test/ui/etapas_cadastro_aluno_test.dart` |
| **RNF07** | **Criptografia Forte de Senhas**<br>*Credenciais protegidas contra vazamento ou interceptação.* | A gestão de credenciais é delegada nativamente ao serviço de identidade **Supabase Auth (GoTrue)**, que aplica hashing criptográfico forte e transporte seguro via TLS/HTTPS. | `test/data/stores/login_form_test.dart`<br>e `test/data/supabase_call_test.dart` |
| **RNF08** | **Dashboards Atualizados em até 3s**<br>*Indicadores da tela inicial devem refletir dados atualizados rapidamente.* | A arquitetura reativa baseada em `AsyncNotifierProvider` do Riverpod escuta mutações de estado e re-renderiza os cards da Home (Alertas de Evasão, Kimonos em Aberto) em menos de 50 milissegundos. | `test/data/stores/home_and_registro_test.dart`<br>e `test/ui/home_page_test.dart` |
| **RNF09** | **Suporte a Modo Escuro (Dark Mode)**<br>*Alternância visual preservando contraste, legibilidade e consistência.* | A `ThemeStore` controla a alternância entre `ThemeMode.light` e `ThemeMode.dark`. Todos os novos testes de widgets verificam explicitamente a renderização limpa e legível em ambos os temas visuais. | `test/ui/turma_widgets_test.dart`<br>e `test/ui/dialogs_historico_test.dart` |
