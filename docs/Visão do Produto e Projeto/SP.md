# Proposta da Solução

## 2.1 Objetivo Geral do Produto

O objetivo do produto é facilitar a organização e o gerenciamento dos alunos e dos recursos do projeto, proporcionando uma visão mais clara, centralizada e acessível das informações. Atualmente, muitos dados importantes ficam dispersos em conversas de WhatsApp ou em registros físicos, o que dificulta a consulta, o acompanhamento e a tomada de decisões por parte da equipe responsável. Com a implementação do sistema, essas informações poderão ser registradas e armazenadas de forma estruturada, permitindo acompanhar a participação dos alunos, controlar recursos do projeto, como kimonos e outros materiais, e manter um histórico organizado das atividades e evoluções. Dessa forma, o sistema contribuirá para tornar a gestão mais eficiente, reduzir a perda de informações e apoiar uma administração mais consciente e planejada do projeto.

## 2.2 Objetivos Específicos (OE) do Produto

Para alcançar o objetivo geral do sistema, foram definidos os seguintes objetivos específicos, numerados para fins de rastreabilidade como os requisitos do projeto. Eles expressam apenas o estado ou resultado desejado; os CPs detalham o "como" isso será viabilizado:

- **OE01:** Cadastro de alunos e responsáveis organizado, centralizado e acessível para consulta.
- **OE03:** Frequência dos alunos monitorada com sinais de evasão identificáveis.
- **OE04:** Disponibilidade e movimentação de kimonos e materiais pedagógicos acompanhadas.
- **OE05:** Responsabilidade sobre os materiais emprestados e suas devoluções rastreável.
- **OE07:** Histórico de ocorrências, orientações e comunicações relevantes dos alunos preservado em um único registro.

## 2.3 Características do Produto (mapeados com os OE do Produto)

No quadro abaixo estão registradas as principais características do produto, relacionadas com os objetivos específicos listados acima.

| ID | Descrição resumida | Valor de negócio principal | OE principal | Contribuição secundária |
| --- | --- | --- | --- | --- |
| CP1 | Cadastro centralizado de alunos e responsáveis. | Reunir as informações em um único lugar para consulta e atualização. | OE01 | OE07 |
| CP2 | Registro de frequência por aula. | Permitir o acompanhamento da presença dos alunos. | OE03 | OE07 |
| CP3 | Acompanhamento de faltas com alertas. | Apoiar a identificação de possíveis evasões. | OE03 | OE07 |
| CP4 | Controle de kimonos e materiais. | Organizar a disponibilidade dos recursos e sua posse atual. | OE04 | OE05 |
| CP5 | Fila de espera para materiais. | Apoiar a distribuição dos recursos conforme a necessidade. | OE05 | OE04 |
| CP6 | Painel de acompanhamento geral. | Acompanhar frequência, uso de recursos e evolução dos alunos. | OE03 | OE07 |
| CP7 | Histórico de ocorrências e orientações. | Manter um registro único para consulta posterior. | OE07 | OE01 |
| CP8 | Proteção e conservação dos dados. | Garantir que as informações permaneçam seguras e disponíveis. | OE01 | OE03 |
| CP9 | Redistribuição de recursos. | Apoiar o reaproveitamento e a entrega de materiais. | OE05 | OE04 |

## 2.4 Tecnologias a Serem Utilizados

Para a construção da solução proposta para o projeto social, serão utilizadas tecnologias adequadas à necessidade de gerenciamento do estoque solidário, ao cadastro e acompanhamento de alunos e o desenvolvimento rápido da aplicação. Para isso, será utilizado o framework Flutter, que é um framework fullstack multiplataforma que permite o desenvolvimento rápido de interfaces nativas. Para persistência de dados será usado o PostgreSQL, por ser bem suportado pelo Flutter, e o Supabase como BaaS, facilitando a implantação do produto final.
Para apoiar o desenvolvimento será utilizado o Git e Github, além de práticas de teste e integração contínua. 

## 2.5 Pesquisa de Mercado e Análise Competitiva

## 2.6 Viabilidade da Proposta

A proposta é viável no contexto da disciplina, considerando o acesso ao cliente, o escopo definido e a possibilidade de entrega de um MVP funcional ao final do semestre. Embora a equipe seja reduzida, a familiaridade dos membros da equipe com as ferramentas escolhidas para a construção da solução, aliado às reuniões semanais entre os membros da equipe, a priorização das funcionalidades essenciais da solução e o feedback frequente do cliente viabilizam o projeto.

## 2.7 Benefícios Esperados

- **Para o cliente:** fortalecer a gestão do projeto social com informações centralizadas, aumento da confiabilidade no acompanhamento de alunos e melhoria no controle de recursos como kimonos e materiais pedagógicos. A solução também deve ampliar a capacidade de planejamento da equipe, apoiar a prestação de contas e reduzir perdas operacionais causadas por registros dispersos.
- **Para os usuários:** proporcionar um atendimento mais organizado, com maior transparência no acompanhamento de frequência, comunicação mais clara entre equipe e responsáveis e distribuição mais justa dos recursos disponíveis. Para instrutores e voluntários, espera-se redução de retrabalho administrativo e acesso mais rápido ao histórico necessário para decisões pedagógicas e sociais.