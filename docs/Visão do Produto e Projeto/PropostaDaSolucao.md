# Proposta da Solução

## 2.1 Objetivo Geral do Produto

O objetivo do produto é facilitar a organização e o gerenciamento dos alunos e dos recursos do projeto, proporcionando uma visão mais clara, centralizada e acessível das informações. Atualmente, muitos dados importantes ficam dispersos em conversas de WhatsApp ou em registros físicos, o que dificulta a consulta, o acompanhamento e a tomada de decisões por parte da equipe responsável. Com a implementação do sistema, essas informações poderão ser registradas e armazenadas de forma estruturada, permitindo acompanhar a participação dos alunos, controlar recursos do projeto, como kimonos e outros materiais, e manter um histórico organizado das atividades e evoluções. Dessa forma, o sistema contribuirá para tornar a gestão mais eficiente, reduzir a perda de informações e apoiar uma administração mais consciente e planejada do projeto.

## 2.2 Objetivos Específicos (OE) do Produto

Para alcançar o objetivo geral do sistema, foram definidos os seguintes objetivos específicos, numerados para fins de rastreabilidade como os requisitos do projeto. Eles expressam apenas o estado ou resultado desejado; os CPs detalham o "como" isso será viabilizado:

* **OE01:** Fortalecer a gestão adimistrativa do projeto através da cerntralização de dados, indicadores estratégicos e automação de alertas para apoiar a tomada de decisão.
* **OE02:** Ampliar a capacidade de retenção dos participantes mediante o acompanhamento sistemático de frequência.
* **OE03:** Assegurar a disponibilidade contínua e a distribuição transparente e equitativa dos recursos necessarios para a prática esportiva.
* **OE04:** Qualificar o acompanhamento pedagógico e psicossocial dos participantes para subsidiar intervenções assertivas.

## 2.3 Características do Produto (mapeados com os OE do Produto)

No quadro abaixo estão registradas as principais características do produto, relacionadas com os objetivos específicos listados acima.

| ID | Descrição resumida | ID | Valor de negócio principal | OE principal | Contribuição secundária |
| :-: | :--- | :-: | :--- | :---: | :---: |
| CP01 | Gestão cadastral de alunos e responsáveis | VN01 | Assegurar a integridade cadastral e os vínculos entre alunos e responsáveis | OE01 | - |
| CP02 | Gestão de usuários e acesso ao sistema | VN02 | Garantir controle e segurança no acesso ao sistema | OE01 | - |
| CP03 | Painel de Bordo (Dashboard) e Alertas Centralizados | VN03 | Acelerar a identificação de prioridades diárias através de visões consolidadas | OE01 | OE04 |
| CP04 | Interface para registro diário de presenças em tempo real | VN04 | Garantir a precisão estatística da participação | OE02 | OE04 |
| CP05 | Gestão de participação em turmas e campeonatos | VN05 | Fortalecer o acompanhamento de participação dos alunos nas atividades esportivas | OE02 | OE04 |
| CP06 | Estrutura de estoque e fluxo de entrada/saída de materiais | VN06 | Assegurar o controle da disponibilidade de recursos | OE03 | - |
| CP07 | Sistema de controle de posse, empréstimos e devoluções | VN07 | Minimizar perdas de ativos e garantir rotatividade justa | OE03 | - |
| CP08 | Banco de registro cronológico de ocorrências pedagógicas | VN08 |Assegurar o registro histórico do acompanhamento pedagógico| OE04 | OE01 |
| CP09 | Módulo de indicadores sociais e análise estratégica | VN09 | Apoiar a tomada de decisão através de indicadores sociais| OE04 | OE02 |

## 2.4 Tecnologias a Serem Utilizados

| Tecnologia                                 | Descrição                                                     | Aréa de aplicação  |
| :----------------------------------------- | :------------------------------------------------------------ | :----------------: |
| :fontawesome-brands-flutter: Flutter       | Framework fullstack para desenvolvimento multiplataforma      |     Fullstack      |
| :simple-postgresql: PostgreSQL             | Banco de dados SQL                                            |      Backend       |
| :simple-supabase: Supabase                 | Plataforma BaaS com autenticação e banco  de dados integrada  |      Backend       |
| :fontawesome-brands-flutter: Flutter Test  | Biblioteca de testes nativa do Flutter                        |       Testes       |
| :fontawesome-brands-flutter: Mockito       | Biblioteca para geração de *mocks*                            |       Testes       |
| :simple-github: Github                     | Repositório para versionamento e colaboração                  | Controle de Versão |
| :simple-githubactions: Github Actions      | Ferramenta de CI/CD, usada para deploy e testes automatizados |       CI/CD        |
| :simple-figma: Figma                       | Ferramenta para prototipação e design de interfaces           |      Design        |
| :material-microsoft-teams: Microsoft Teams | Plataforma para comunicação e reuniões internas               |    Comunicação     |
| :simple-googlemeet: Google Meet            | Plataforma para reuniões com o cliente                        |    Comunicação     |
| :simple-whatsapp: WhatsApp                 | Plataforma para comunicações rápidas entre a equipe           |    Comunicação     |

## 2.5 Pesquisa de Mercado e Análise Competitiva

No mercado atual de sistemas de gestão e Dashboards, as soluções dominantes, como o DojoApp (Dojo Brasil), oferecem plataformas robustas com foco em performance corporativa. No entanto, após uma análise técnica, identificamos que essas ferramentas apresentam fragilidades quando aplicadas a contextos de projetos sociais ou instituições sem fins lucrativos:

- **DojoApp / Dojo Brasil:** Estas plataformas são projetadas com um viés estritamente comercial, visando maximizar o lucro da empresa e atrair novos investidores. Além disso, entregam interfaces de alta complexidade técnica, o que se torna um obstáculo para usuários que não possuem capacitação prévia ou tempo para treinamentos exaustivos.

A nossa solução irá se diferenciar por:

- **Foco em Propósito Social e Organização:** Diferente dos concorrentes, o sistema não visa gerar lucro ou atrair investimentos financeiros. O objetivo central é fornecer uma estrutura organizacional sólida para que projetos nobres possam crescer com ordem e eficiência, priorizando o impacto social em vez do retorno financeiro.

- **Interface Simplista e Intuitiva:** Enquanto o mercado foca em alta complexidade, nosso produto preza pela simplicidade. A ferramenta foi desenhada para ser operada por qualquer pessoa, sem necessidade de capacitação técnica, garantindo que a tecnologia seja um facilitador e não uma barreira.

- **Gestão de Recursos e Frequência:** O sistema foca no que é essencial para a instituição: o controle preciso da frequência dos alunos e a gestão clara dos recursos disponíveis. As informações são entregues de forma direta, permitindo uma tomada de decisão rápida sobre a saúde do projeto.

## 2.6 Viabilidade da Proposta

A proposta é viável no contexto da disciplina, considerando o acesso ao cliente, o escopo definido e a possibilidade de entrega de um MVP funcional ao final do semestre. Embora a equipe seja reduzida, a familiaridade dos membros da equipe com as ferramentas escolhidas para a construção da solução, aliado às reuniões semanais entre os membros da equipe, a priorização das funcionalidades essenciais da solução e o feedback frequente do cliente viabilizam o projeto.

## 2.7 Benefícios Esperados

- **Para o cliente:** fortalecer a gestão do projeto social com informações centralizadas, aumento da confiabilidade no acompanhamento de alunos e melhoria no controle de recursos como kimonos e materiais pedagógicos. A solução também deve ampliar a capacidade de planejamento da equipe, apoiar a prestação de contas e reduzir perdas operacionais causadas por registros dispersos.

- **Para os usuários:** proporcionar um atendimento mais organizado, com maior transparência no acompanhamento de frequência, comunicação mais clara entre equipe e responsáveis e distribuição mais justa dos recursos disponíveis. Para instrutores e voluntários, espera-se redução de retrabalho administrativo e acesso mais rápido ao histórico necessário para decisões pedagógicas e sociais.
