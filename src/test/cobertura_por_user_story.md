# Matriz de Cobertura de Testes por User Story (US)

Este documento mapeia e organiza a cobertura dos testes automatizados (Unitários de Store/Services e Testes de UI/Widgets) do projeto **Salvando Vidas através do Esporte**, estruturando cada bateria de teste diretamente sob a **História de Usuário (User Story)** correspondente do Backlog do Produto.

---

## 1. Gestão de Alunos

### Épico: Cadastro e Manutenção de Dados Cadastrais

#### **US-01**: Registrar e buscar dados de alunos
- **Stores / Controllers**: `CadastroAluno` (`data/stores/cadastro_aluno/`), `PesquisaAlunoStore` (`data/stores/pesquisa_aluno/`)
- **Testes de Store (`test/data/stores/`)**:
  - `cadastros_forms_test.dart` → Valida regras, limpezas, preenchimento e submissão do formulário de alunos.
  - `update_and_pesquisa_test.dart` → Valida carregamento inicial, listagem e filtro por texto/turma na pesquisa de alunos.
- **Testes de Service (`test/data/services/`)**:
  - `aluno_service_test.dart` → Valida chamadas RPC de cadastro (`cadastrarAluno`) e listagem (`listarAlunos`).
- **Testes de Interface (`test/ui/`)**:
  - `pesquisa_alunos_page_test.dart` → Valida a renderização da barra de busca e listagem na tela.

#### **US-02**: Editar dados de alunos e inativá-los quando saírem
- **Stores / Controllers**: `UpdateAlunoStore` (`data/stores/update_aluno/`), `PesquisaAlunoStore` (método `inativarAluno`)
- **Testes de Store (`test/data/stores/`)**:
  - `update_and_pesquisa_test.dart` → Testes de `UpdateAluno Store Tests build and updates` e alternância de status ativo/inativo.
- **Testes de Service (`test/data/services/`)**:
  - `aluno_service_test.dart` → Valida chamadas RPC de atualização (`atualizarAluno`) e inativação (`inativarAluno`).
- **Testes de Interface (`test/ui/`)**:
  - `editar_aluno_page_test.dart` → Valida o carregamento dos dados no formulário de edição.
  - `aluno_expandable_card_test.dart` → Valida a exibição do botão/menu de inativar aluno.

#### **US-03**: Reativar o cadastro de um aluno inativado
- **Stores / Controllers**: `PesquisaAlunoStore` (método `reativarAluno`)
- **Testes de Store (`test/data/stores/`)**:
  - `update_and_pesquisa_test.dart` → Valida o método `reativarAluno` alterando o estado da lista e restaurando o aluno.
- **Testes de Service (`test/data/services/`)**:
  - `aluno_service_test.dart` → Valida a chamada RPC `reativarAluno`.

---

## 2. Gestão de Turmas

### Épico: Criação e Manutenção de Turmas

#### **US-04**: Criar e editar turmas com dias e horários
- **Stores / Controllers**: `TurmasStore` (`data/stores/turmas/`)
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Testes de `TurmasStore Tests build`, carregamento e atualização da grade de turmas.
- **Testes de Service (`test/data/services/`)**:
  - `turma_service_test.dart` → Valida a busca e persistência das turmas.

#### **US-05**: Encerrar turmas inativas ou reativar turmas preservando histórico
- **Stores / Controllers**: `TurmasStore`
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Valida a manutenção de estado e transição de turmas.

#### **US-06**: Filtrar turmas por dia ou horário
- **Stores / Controllers**: `TurmasStore`
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Valida filtros e seleção de turmas no estado da aplicação.

### Épico: Matrículas e Participação em Turmas

#### **US-07**: Matricular um aluno em uma turma
#### **US-08**: Cancelar a matrícula de um aluno em uma turma
- **Testes de Service / Store**:
  - `aluno_service_test.dart` e `update_and_pesquisa_test.dart` → Verificação de vinculação do `idTurma` na entidade do aluno e reflexo na chamada da turma.

---

## 3. Controle de Frequência e Evasão

### Épico: Registro de Presença em Aula

#### **US-09**: Registrar a presença dos alunos de forma ágil
#### **US-10**: Corrigir um registro de presença lançado
- **Stores / Controllers**: `PresencaStore` (`data/stores/presenca/`)
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Testes `Tests build, updateProfessor, togglePresenca, updateData`. Valida alternância de presença/falta e salvamento em lote.
- **Testes de Service (`test/data/services/`)**:
  - `presenca_service_test.dart` → Valida inserção, atualização e listagem de presenças via `PresencaService`.

#### **US-11**: Registrar o conteúdo trabalhado em cada aula
- **Testes de Store (`test/data/stores/`)**:
  - `theme_turmas_presenca_test.dart` → Valida `updateObservacao` e persistência do diário de aula.

### Épico: Monitoramento e Prevenção à Evasão

#### **US-12**: Consultar o histórico de presença do aluno
- **Stores / Controllers**: `HistoricoFrequenciaStore` (`data/stores/emprestimo/`)
- **Testes de Store (`test/data/stores/`)**:
  - `historico_frequencia_test.dart` → Valida o cálculo de presenças, faltas e percentual de assiduidade do aluno.

#### **US-13**: Acompanhar alertas visuais de inatividade diretamente no painel principal
- **Stores / Controllers**: `HomeStore` (`data/stores/home/`)
- **Testes de Store (`test/data/stores/`)**:
  - `home_and_registro_test.dart` → Valida o cálculo do card de **Alertas de Evasão** no dashboard principal.
- **Testes de Interface (`test/ui/`)**:
  - `home_page_test.dart` → Valida a renderização e responsividade do card de Alertas de Evasão na tela principal.

---

## 4. Estoque Solidário de Kimonos

### Épico: Controle de Inventário & Empréstimos e Devoluções

#### **US-14**: Registrar doações e consultar estoque disponível
#### **US-15**: Registrar perda ou dano em kimonos
#### **US-16**: Registrar empréstimo de kimono a um aluno
#### **US-17**: Registrar devolução de um kimono
- **Stores / Controllers**: `GestaoKimonosStore`, `RegistroKimonosStore`, `GestaoEmprestimosStore`
- **Testes de Store (`test/data/stores/`)**:
  - `gestao_stores_test.dart` → Testes de `GestaoKimonosStore build`, `GestaoEmprestimosStore filtros e updates`. Valida contagem de estoque, empréstimos ativos e devoluções.
  - `home_and_registro_test.dart` → Testes de `RegistroKimonosStore methods & getters` (validação de formulário de empréstimo/doação/baixa).
- **Testes de Service (`test/data/services/`)**:
  - `kimono_service_test.dart` → Valida chamadas `obterEstoque`, `cadastrarDoacao`, `cadastrarPerda`, `emprestarKimono` e `devolverKimono`.

---

## 5. Acompanhamento Pedagógico e Engajamento

### Épico: Engajamento com a Comunidade

#### **US-18**: Ver no dashboard os aniversariantes da semana
- **Stores / Controllers**: `HomeStore`
- **Testes de Store (`test/data/stores/`)**:
  - `home_and_registro_test.dart` → Testes de `Tests HomeStore build, sort and aniversariantes`. Valida a ordenação por dias restantes e identificação de aniversariantes do dia.
- **Testes de Interface (`test/ui/`)**:
  - `home_page_test.dart` → Valida a exibição da lista de aniversariantes e abertura do modal interativo.

#### **US-19**: Registrar orientações passadas aos responsáveis
#### **US-20**: Registrar e editar observações sobre o desenvolvimento de um aluno
#### **US-21**: Navegar pelos registros pedagógicos cronologicamente
- **Testes de Store e Service**:
  - `historico_frequencia_test.dart` e `presenca_service_test.dart` → Valida obtenção do histórico de observações e diários por aluno.

#### **US-22**: Trajetória de faixas e graduações
#### **US-23**: Gerar e exportar relatório de impacto social
- **Testes de Domínio e Validadores (`test/data/`)**:
  - `misc_and_domain_test.dart` → Valida serialização das graduações/faixas (`FaixaBadge`).

---

## 6. Gestão de Campeonatos

#### **US-24 a US-27**: Cadastrar campeonatos, inscrições e participações
- **Cobertura Base**:
  - Testes estruturais de roteamento (`router_test.dart`) e integridade de domínio (`misc_and_domain_test.dart`).

---

## 7. Gestão de Usuários e Acessos

### Épico: Cadastro e Manutenção de Voluntários

#### **US-28**: Cadastrar e editar voluntários com senhas protegidas
#### **US-29**: Gerenciar o status de atividade dos voluntários (inativar/reativar)
#### **US-30**: Buscar voluntários por nome
- **Stores / Controllers**: `CadastroVoluntarioForm`, `UpdateVoluntario`
- **Testes de Store (`test/data/stores/`)**:
  - `cadastros_forms_test.dart` → Valida `CadastroVoluntarioForm` (validação de senha, email, nível de acesso).
  - `update_and_pesquisa_test.dart` → Valida `UpdateVoluntario Store Tests` (edição e alteração de status ativo/inativo).
- **Testes de Service (`test/data/services/`)**:
  - `user_service_test.dart` → Valida `UserService` (`listUsers`, `inactivateUser`, `reactivateUser`, `updateUser`).

### Épico: Controle de Acesso e Segurança

#### **US-31**: Realizar o login com credenciais seguras
#### **US-32**: Encerrar sessão (Logout)
- **Stores / Controllers**: `LoginForm`, `LoginController`
- **Testes de Store (`test/data/stores/`)**:
  - `login_form_test.dart` → Valida validações de email e senha no formulário.
  - `cadastros_forms_test.dart` → Testes de `LoginForm Store Tests build, updates and validation`.
- **Testes de Service (`test/data/services/`)**:
  - `user_service_test.dart` → Valida identificação de usuário logado e limpeza de sessão no logout (`logout`).
- **Testes de Interface (`test/ui/`)**:
  - `login_page_test.dart` e `formulario_login_test.dart` → Valida comportamento visual da tela de login e reatividade a erros de autenticação.
