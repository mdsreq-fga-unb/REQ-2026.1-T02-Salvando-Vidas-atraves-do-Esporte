# Registro de Mudanças Pós-MVP

Este documento registra as alterações realizadas nos artefatos de requisitos após a definição do MVP. As mudanças incluem adições, remoções, reescritas, fusões e renumerações em Requisitos Funcionais, Requisitos Não Funcionais e Histórias de Usuário, acompanhadas de suas respectivas justificativas, com o objetivo de manter a documentação consistente e alinhada à evolução do projeto.

## Unidade 3

### Requisitos Funcionais

| ID (Antigo) | Tipo | O que era | O que mudou | Justificativa |
| :---: | :---: | :--- | :--- | :--- |
| RF23 + RF26 | Fusão | RF23 — Registrar e vincular observações pedagógicas ao aluno <br> RF26 — Visualizar orientações e observações pedagógicas | Unificados em um único RF23 | Redundância identificada entre os dois requisitos; a funcionalidade de visualização estava contida na de registro |
| RF14 | Reescrita | Registrar o conteúdo e as ocorrências gerais da aula | Escrita corrigida para maior clareza e precisão | Ajuste textual para melhor delimitar o escopo da funcionalidade |
| RF21 | Reescrita | Registrar empréstimo de kimono | Escrita corrigida para maior clareza e precisão | Ajuste textual para melhor delimitar o escopo da funcionalidade |
| RF22 | Reescrita | Registrar devolução de kimono | Escrita corrigida para maior clareza e precisão | Ajuste textual para melhor delimitar o escopo da funcionalidade |
| *(novo)* RF41 | Adição | — | Realizar login (autenticação) | Requisito de autenticação não estava explicitado como RF independente |
| *(novo)* RF42 | Adição | — | Reativar cadastro de aluno e responsável | Ciclo de vida do cadastro exige reativação além da inativação |
| *(novo)* RF43 | Adição | — | Reativar cadastro de usuário voluntário | Ciclo de vida do voluntário exige reativação além da inativação |
| *(novo)* RF44 | Adição | — | Reativar turma | Ciclo de vida da turma exige reativação além da inativação |

### Requisitos Não Funcionais

| ID (Antigo) | Tipo | O que era | O que mudou | Justificativa |
| :---: | :---: | :--- | :--- | :--- |
| RNF02 | Remoção | O sistema deve exibir alerta de risco de evasão quando um aluno tiver 2 semanas de faltas consecutivas | Removido | Reclassificado como Regra de Negócio; não é um requisito de qualidade do sistema |
| RNF04 | Reescrita | Segurança geral de dados | Privacidade de Dados e Retenção Segura (LGPD) | Reescrita para explicitar conformidade com a LGPD e detalhar inativação lógica de cadastros |
| *(novo)* RNF10 | Adição | — | Interface com suporte a Modo Escuro (Dark Mode) alternável | Demanda de usabilidade identificada para uso em ambientes com baixa luminosidade |

### Histórias de Usuário

| ID (Antigo) | Tipo | O que era | O que mudou | Justificativa |
| :---: | :---: | :--- | :--- | :--- |
| *(nova)* US-35 | Adição | — | Como **Voluntário**, quero realizar o login com minhas credenciais, para acessar as funcionalidades protegidas de forma segura | Decorrente da adição do RF41 |
| *(nova)* US-36 | Adição | — | Como **Coordenador**, quero reativar o cadastro de um aluno ou responsável inativado, para que ele retome as atividades sem redigitar o histórico | Decorrente da adição do RF42 |
| *(nova)* US-37 | Adição | — | Como **Coordenador**, quero reativar o perfil de um usuário voluntário, para restaurar rapidamente seu acesso ao sistema | Decorrente da adição do RF43 |
| US-06 | Atualização | Como **Coordenador**, quero encerrar turmas inativas, para manter a memória do que o projeto realizou | Expandida para incluir reativação: "...ou reativar turmas preservando o histórico de aulas e alunos" | Decorrente da adição do RF44; a US precisou cobrir o ciclo completo da turma |

---

## Unidade 4

### Requisitos Funcionais

| ID (Novo) | Tipo | O que era | O que mudou | Justificativa |
| :---: | :---: | :--- | :--- | :--- |
| RF05 + RF06 | Remoção | RF05 — Vincular responsável ao aluno <br> RF06 — Desvincular responsável ao aluno | Removidos | Vínculo com responsável passou a ser tratado diretamente no cadastro do aluno (RF01), eliminando a necessidade de RFs separados |
| RF40 | Remoção | Gerenciar níveis de acesso dos usuários | Removido | Funcionalidade fora do escopo do MVP; controle de acesso simplificado para perfil único por ora |
| RF17 | Reescrita | Listar alunos em risco de evasão — Permitir a geração de uma relação dos alunos que atingiram os parâmetros de alerta para risco de evasão | Monitorar alunos com risco de evasão — Permitir a sinalização visual de alunos com alta inatividade de frequência | Nome e descrição alinhados ao comportamento real da funcionalidade: alerta visual, não geração de lista |
| RNF06 | Reescrita | Registro de auditoria (Logs) de estoque — incluindo datas, usuários e ações | Removida a menção a "datas" da descrição | Refinamento para evitar especificação técnica prematura na camada de requisitos |

### Requisitos Não Funcionais

| ID (Novo) | Tipo | O que era | O que mudou | Justificativa |
| :---: | :---: | :--- | :--- | :--- |
| RNF01 | Remoção | Dashboard deve apresentar as informações essenciais em até três cliques | Removido | Reclassificado como Regra de Negócio de UX; não mensurável como RNF de sistema |

### Histórias de Usuário

| ID (Antigo) | ID (Novo) | Tipo | O que era | O que mudou | Justificativa |
| :---: | :---: | :---: | :--- | :--- | :--- |
| US-03 + US-04 | — | Remoção | US-03 — Vincular responsáveis a cada aluno <br> US-04 — Remover vínculo entre aluno e responsável | Removidas | Decorrente da remoção de RF05 e RF06; vínculo com responsável incorporado ao cadastro do aluno |
| US-23 | — | Remoção | Como **Voluntário**, quero corrigir e revincular um registro pedagógico ao aluno correto | Removida | Funcionalidade incorporada à US-21 (Registrar e editar observações pedagógicas) |
| US-33 | — | Remoção | Como **Coordenador**, quero definir o nível de permissão de cada voluntário | Removida | Decorrente da remoção do RF40; fora do escopo do MVP |
| US-36 | US-03 | Realocação | Épico: *Vínculos entre Aluno e Responsável* | Realocada para Épico: *Cadastro e Manutenção de Dados Cadastrais* | Com a remoção do épico de vínculos, a US de reativação de aluno passa a pertencer ao épico principal de cadastro |
| US-31 + US-37 | US-29 | Fusão | US-31 — Inativar voluntário preservando histórico <br> US-37 — Reativar perfil de usuário voluntário | Unificadas em US-29 — Gerenciar status de atividade dos voluntários (inativar ou reativar) | As duas histórias tratam do mesmo ciclo de vida do voluntário; fusão evita fragmentação desnecessária |
| US-21 | US-20 | Atualização | Como **Voluntário**, quero registrar observações sobre o desenvolvimento de um aluno | Expandida para incluir edição: "...quero registrar e editar observações..." e incorporou RF25 | Absorção da US-23 removida; edição e registro são parte do mesmo fluxo |
| US-13 | US-12 | Reescrita textual | Como Coordenador, quero consultar o histórico de frequência para identificar mudanças no padrão de presença antes que virem abandono | Como **Coordenador**, quero consultar o histórico de presença do aluno para acompanhar sua frequência contínua e identificar faltas recorrentes | Reescrita para maior clareza e formalidade; remoção de linguagem informal ("virem abandono") |

### Renumeração Geral de IDs

| Artefato | Motivo | Impacto |
| :--- | :--- | :--- |
| RFs | Remoção de RF05, RF06 e RF40; reordenação de RF42, RF43, RF44 para posições coerentes com seu contexto | 41 RFs renumerados sequencialmente de RF01 a RF41 |
| RNFs | Remoção de RNF01 | 9 RNFs renumerados sequencialmente de RNF01 a RNF09 |
| USs | Remoção de US-03, US-04, US-23, US-33; fusão de US-31+US-37; realocação de US-36 | 32 USs renumeradas sequencialmente de US-01 a US-32 |
