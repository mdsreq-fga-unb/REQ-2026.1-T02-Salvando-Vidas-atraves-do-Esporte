# Backlog do Produto

O backlog do produto é uma lista ordenada e dinâmica de todas as funcionalidades, melhorias e correções necessárias para o desenvolvimento da solução. Ele serve como a principal fonte de requisitos para a equipe, sendo constantemente refinado à medida que o entendimento sobre o projeto evolui e novos feedbacks do cliente são coletados. No contexto do processo RAD, o backlog é essencial para garantir que as iterações foquem no que gera maior valor de negócio e impacto social imediato.

## 10.1 Backlog Geral

A presente seção detalha o Backlog Geral do produto, organizado a partir da visão orientada a valor em Temas, Épicos e Histórias de Usuário.

> **Nota sobre a Elicitação das Histórias de Usuário:** Em alinhamento com as práticas do método RAD, as Histórias de Usuário apresentadas neste backlog não constituem transcrições literais das falas do cliente. Elas foram formuladas, interpretadas e estruturadas pela equipe técnica com base nas dores e necessidades mapeadas durante os workshops e entrevistas, sendo continuamente validadas e refinadas com os stakeholders ao longo dos ciclos de prototipagem.

### Visão Estrutural do Backlog

Antes do detalhamento granular, apresenta-se a síntese arquitetural do escopo do produto. A estrutura macro está dividida em Temas centrais de negócio, que se desdobram em Épicos e totalizam as Histórias de Usuário (US) mapeadas nesta versão preliminar:

| Tema | Épicos Abrangidos | Quantidade de Histórias (US) |
| :--- | :--- | :---: |
| Gestão de Alunos e Responsáveis | • Cadastro e Manutenção de Dados Cadastrais<br>• Vínculos entre Aluno e Responsável | 4 |
| Gestão de Turmas | • Criação e Manutenção de Turmas<br>• Matrículas e Participação em Turmas | 5 |
| Controle de Frequência e Evasão | • Registro de Presença em Aula<br>• Monitoramento e Prevenção à Evasão | 5 |
| Estoque Solidário de Kimonos | • Controle de Inventário<br>• Empréstimos e Devoluções | 4 |
| Acompanhamento Pedagógico e Engajamento | • Engajamento com a Comunidade<br>• Registros e Observações Pedagógicas<br>• Evolução e Impacto Social | 7 |
| Gestão de Campeonatos | • Configuração de Eventos Competitivos<br>• Participação dos Alunos em Competições | 4 |
| Gestão de Usuários e Acessos | • Cadastro e Manutenção de Voluntários<br>• Controle de Acesso e Segurança | 5 |
|  **Total:**<br><br>**7 Temas** | <br><br>**15 Épicos** | <br><br>**34 US** |

---

### Especificação das Histórias de Usuário

---

#### Tema: Gestão de Alunos e Responsáveis

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-01 | Cadastro e Manutenção de Dados Cadastrais | Como **Coordenador**, quero registrar e buscar dados de alunos e responsáveis, para reduzir o uso de fichas de papel. | RF01, RF04 | - |
| US-02 | Cadastro e Manutenção de Dados Cadastrais | Como **Coordenador**, quero editar dados de alunos e responsáveis e inativá-los quando saírem, para manter o cadastro organizado sem apagar o histórico. | RF02, RF03 | - |
| US-03 | Vínculos entre Aluno e Responsável | Como **Coordenador**, quero vincular responsáveis a cada aluno, para saber com quem contatar quando necessário. | RF05 | - |
| US-04 | Vínculos entre Aluno e Responsável | Como **Coordenador**, quero remover o vínculo entre aluno e responsável, para manter as informações de tutela sempre atualizadas. | RF06 | - |

---

#### Tema: Gestão de Turmas

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-05 | Criação e Manutenção de Turmas | Como **Coordenador**, quero criar e editar turmas com dias, horários, faixa etária e professor, para organizar a grade do projeto. | RF07, RF08 | - |
| US-06 | Criação e Manutenção de Turmas | Como **Coordenador**, quero encerrar turmas inativas preservando o histórico de aulas e alunos, para manter a memória do que o projeto realizou. | RF09 | - |
| US-07 | Criação e Manutenção de Turmas | Como **Voluntário**, quero filtrar turmas por dia, horário ou professor, para localizar rapidamente a turma desejada. | RF10 | - |
| US-08 | Matrículas e Participação em Turmas | Como **Coordenador**, quero matricular um aluno em uma turma, para que ele apareça nas listas de chamada corretas. | RF11 | - |
| US-09 | Matrículas e Participação em Turmas | Como **Coordenador**, quero cancelar a matrícula de um aluno em uma turma, para que a chamada reflita apenas quem frequenta ativamente. | RF12 | - |

---

#### Tema: Controle de Frequência e Evasão

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-10 | Registro de Presença em Aula | Como **Voluntário**, quero registrar a presença dos alunos de forma ágil, para fechar a chamada ainda durante a aula. | RF13 | RNF04 |
| US-11 | Registro de Presença em Aula | Como **Voluntário**, quero corrigir um registro de presença lançado errado, para manter o histórico de frequência confiável. | RF15 | - |
| US-12 | Registro de Presença em Aula | Como **Voluntário**, quero registrar o conteúdo trabalhado em cada aula, para manter um diário pedagógico da turma. | RF14 | - |
| US-13 | Monitoramento e Prevenção à Evasão | Como **Coordenador**, quero consultar o histórico de frequência de um aluno por período, para identificar mudanças no padrão de presença antes que virem abandono. | RF16 | - |
| US-14 | Monitoramento e Prevenção à Evasão | Como **Coordenador**, quero ver a lista de alunos com duas semanas seguidas de faltas, para contatar a família antes que a criança abandone o projeto. | RF17 | RNF02, RNF10 |

---

#### Tema: Estoque Solidário de Kimonos

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-15 | Controle de Inventário | Como **Coordenador**, quero registrar doações de kimonos e consultar o estoque disponível, para nunca ficar sem uniforme para novos alunos. | RF18, RF20 | RNF07 |
| US-16 | Controle de Inventário | Como **Coordenador**, quero dar baixa em kimonos danificados, para que o estoque reflita apenas o que pode ser emprestado. | RF19 | RNF07 |
| US-17 | Empréstimos e Devoluções | Como **Coordenador**, quero registrar o empréstimo de um kimono a um aluno, para saber onde cada uniforme está a qualquer momento. | RF21 | RNF07 |
| US-18 | Empréstimos e Devoluções | Como **Coordenador**, quero registrar a devolução de um kimono, para reintegrá-lo ao estoque disponível para empréstimo. | RF22 | RNF07 |

---

#### Tema: Acompanhamento Pedagógico e Engajamento

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-19 | Engajamento com a Comunidade | Como **Voluntário**, quero ver no dashboard os aniversariantes da semana, para que a equipe celebre com os alunos no treino. | RF30 | RNF01, RNF03 |
| US-20 | Engajamento com a Comunidade | Como **Voluntário**, quero registrar orientações passadas aos responsáveis de um aluno, para manter histórico claro das conversas realizadas. | RF24 | - |
| US-21 | Registros e Observações Pedagógicas | Como **Voluntário**, quero registrar observações sobre o desenvolvimento de um aluno, para que toda a equipe acompanhe sua trajetória de forma integrada. | RF23 | - |
| US-22 | Registros e Observações Pedagógicas | Como **Voluntário**, quero navegar pelos registros pedagógicos de um aluno em ordem cronológica, para acompanhar como seu desenvolvimento evoluiu no projeto. | RF27 | - |
| US-23 | Registros e Observações Pedagógicas | Como **Voluntário**, quero corrigir e revincular um registro pedagógico ao aluno correto, para garantir precisão no histórico de cada criança. | RF25, RF26 | - |
| US-24 | Evolução e Impacto Social | Como **Coordenador**, quero visualizar a trajetória de faixas e graduações de cada aluno, para reconhecer formalmente sua evolução no jiu-jitsu. | RF29 | - |
| US-25 | Evolução e Impacto Social | Como **Coordenador**, quero gerar e exportar um relatório de impacto social dos alunos, para apresentar resultados à comunidade e a potenciais doadores. | RF28 | - |

---

#### Tema: Gestão de Campeonatos

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-26 | Configuração de Eventos Competitivos | Como **Coordenador**, quero cadastrar e editar campeonatos com nome, data e local, para registrar os eventos que o projeto disputa. | RF31, RF32 | - |
| US-27 | Configuração de Eventos Competitivos | Como **Coordenador**, quero encerrar um campeonato preservando participantes e registros, para manter o histórico fiel das competições realizadas. | RF33 | - |
| US-28 | Participação dos Alunos em Competições | Como **Coordenador**, quero inscrever um aluno em um campeonato, para registrar formalmente sua participação no evento. | RF34 | - |
| US-29 | Participação dos Alunos em Competições | Como **Coordenador**, quero retirar a inscrição de um aluno de um campeonato, para que apenas participantes confirmados estejam registrados. | RF35 | - |

---

#### Tema: Gestão de Usuários e Acessos

| ID da US | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :---: | :---: |
| US-30 | Cadastro e Manutenção de Voluntários | Como **Coordenador**, quero cadastrar e editar voluntários com senhas protegidas, para manter os perfis da equipe sempre atualizados e seguros. | RF36, RF37 | RNF09 |
| US-31 | Cadastro e Manutenção de Voluntários | Como **Coordenador**, quero inativar um voluntário preservando seu histórico de ações, para garantir que apenas membros ativos acessem o sistema. | RF38 | - |
| US-32 | Controle de Acesso e Segurança | Como **Coordenador**, quero definir o nível de permissão de cada voluntário, para proteger os dados sensíveis dos alunos conforme cada função. | RF41 | RNF06 |
| US-33 | Controle de Acesso e Segurança | Como **Voluntário**, quero encerrar minha sessão ao terminar o uso, para impedir acessos indevidos pelo meu dispositivo. | RF40 | - |
| US-34 | Cadastro e Manutenção de Voluntários | Como **Coordenador**, quero buscar voluntários por nome ou função, para localizar rapidamente qualquer colaborador sem percorrer toda a listagem. | RF39 | - |

---

> **Nota 1:** O dimensionamento de esforço (Planning Poker), a avaliação de riscos, as dependências, a priorização (MoSCoW e Valor de Negócio) e os Critérios de Aceitação que definem o Produto Mínimo Viável (MVP) estão especificados taticamente na **Seção 10.2**.

> **Nota 2:** Os Requisitos Não Funcionais transversais **RNF05** (LGPD) e **RNF08** (Responsividade), que representam restrições de todo o sistema, não foram descritos como Histórias de Usuário individuais. Eles atuam como restrições arquiteturais e compõem a **Definition of Done (DoD)** que baliza o desenvolvimento de todas as histórias.

---

