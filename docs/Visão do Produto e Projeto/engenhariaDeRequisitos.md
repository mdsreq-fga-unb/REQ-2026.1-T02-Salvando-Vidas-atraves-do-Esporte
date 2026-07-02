# Engenharia de Requisitos

## 5.1 Atividades e Técnicas de ER
Abaixo, detalhamos as atividades da Engenharia de Requisitos (ER) associadas às técnicas que serão utilizadas no contexto do RAD, cujo foco é o engajamento contínuo do cliente por meio de prototipagem e desenvolvimento em ciclos curtos.

**Planejamento de Requisitos**

- **Elicitação e Descoberta:**
    <!--- **Workshop JAD (Joint Application Design) adaptado ao contexto do projeto:** Sessões de trabalho colaborativo envolvendo a equipe de desenvolvimento, o cliente e os usuários finais para levantar rapidamente as necessidades de negócio, mapear as funcionalidades centrais do sistema e alinhar as expectativas gerais do projeto.-->
    - **Entrevistas e Brainstorming:** Utilizados no início do projeto e a cada iteração para capturar as dores dos usuários e propor soluções em conjunto com os stakeholders.

- **Análise e Consenso:**
    - **Priorização MoSCoW:** Técnica de priorização compatível com ambientes iterativos como o RAD, responsável por classificar os requisitos em *Must have* (essenciais para o protótipo/MVP), *Should Have*, *Could Have* e *Won't Have*, garantindo que a equipe foque no que gera mais valor em menos tempo.
    - **Matriz Avaliação Técnica × Valor de Negócio:** Para ir além do MoSCoW, esta técnica posiciona os requisitos cruzando o valor percebido pelo cliente com a complexidade/esforço técnico estimado pela equipe, permitindo identificar entregas de alto valor e organizando o esforço de forma mais realista.
        - Para definir o eixo de esforço técnico de forma colaborativa, a equipe utilizará o **Planning Poker** como técnica auxiliar: uma estimativa ágil baseada em consenso onde os requisitos são debatidos, votados simultaneamente em complexidade usando a sequência modificada de Fibonacci (1,2, 3, 5, 8, 13, ...), e as divergências são discutidas até o consenso, garantindo uma avaliação realista e democrática antes de organizar as entregas na matriz.

- **Declaração de Requisitos:**
    - **Temas, Épicos, User Stories (Histórias de Usuário) e Critérios de Aceitação:** Como complemento à abordagem de prototipação do RAD e para dar suporte ao caráter ágil da abordagem híbrida, os requisitos são organizados em temas e épicos, e detalhados em histórias focadas no usuário. As histórias possuem os seus próprios Critérios de Aceitação (condições que o requisito deve atender para ser considerado válido). Separadamente, para gerenciar o fluxo de trabalho, a equipe utiliza políticas de entrada e saída, como a *Definition of Ready (DoR)* e a *Definition of Done (DoD)*. Essa estrutura é essencial, pois auxilia na organização do backlog inicial e no alinhamento com os stakeholders, especialmente usuários com baixo letramento digital.

- **Verificação e Validação de Requisitos:**
    - **V&V Contínua e Iterativa:** Avaliação para garantir que os requisitos estão estruturalmente corretos (verificação) e atendem às reais necessidades de negócio (validação). No RAD, essa prática não se limita ao início do projeto; ela ocorre a cada iteração, em trabalho conjunto entre a equipe e os clientes, mantendo o alinhamento constante das expectativas. 

- **Organização e Atualização:**
    - **Matriz de Rastreabilidade:** Estruturação do backlog e garantia da rastreabilidade explícita dos requisitos. Para manter a coerência do que será construído, a equipe utilizará o mapeamento contínuo seguindo a cadeia de rastreabilidade: *OE* (Objetivos Específicos) - *CP* (Característica do Produto) - *requisito/user story* - *critério de aceitação* - *protótipo* - *validação* - *entrega*.

**Design do Usuário (Prototipagem Iterativa)**

- **Análise e Consenso:** Negociação contínua com os stakeholders sobre quais funcionalidades farão parte do protótipo atual, avaliando trade-offs entre usabilidade e viabilidade técnica.

- **Declaração de Requisitos:** Atualização das histórias de usuário e criação de novos critérios de aceitação à medida que a interação com o protótipo exige refinamentos textuais e técnicos.

- **Representação de Requisitos:**
    - **Prototipagem Rápida (Wireframes e Mockups):** No RAD, a representação visual é a técnica central para tornar os requisitos concretos, visíveis e validáveis. Consiste na criação iterativa de protótipos de interface, telas e fluxos navegáveis, que servem como principal modelo visual para que os stakeholders compreendam, validem e refinem a solução antes do desenvolvimento completo.

- **Verificação e Validação de Requisitos:**
    - **Validação de Protótipos com o Cliente:** Sessões onde os *protótipos* são testados em sessões nas quais o cliente interage diretamente com as interfaces e fluxos propostos. O feedback imediato, obtido de forma visual e prática, permite validar se o entendimento dos requisitos, incluindo as histórias de usuário associadas, está correto e alinhado às necessidades reais.

- **Elicitação e Descoberta (Refinamento):**
    - **Refinamento Iterativo (Sessões JAD contínuas):** Durante a avaliação dos protótipos, novos requisitos ou ajustes (*refinamentos*) são descobertos iterativamente a partir da interação visual do usuário.

**Construção Rápida (Iterativa)**

- **Organização e Atualização:**
    - **Gerenciamento e Refinamento de Backlog (Grooming):** Manutenção contínua da lista de requisitos (backlog) ao longo dos ciclos iterativos, ajustando prioridades e detalhando histórias à medida que novos aprendizados surgem a partir dos protótipos avaliados.

- **Verificação e Validação de Requisitos:**
    - **Verificação (Checklists e Revisão Técnica):** Verificação técnica realizada ao final de cada ciclo de construção rápida, a equipe realiza a aplicação de checklists internos e a revisão contra a Definition of Done (DoD) para atestar que o incremento foi construído de forma correta, consistente e testável. 

**Transição (Cutover)**

- **Verificação e Validação de Requisitos:**
    - **Validação Final (Homologação / UAT Final):** Validação definitiva do sistema consolidado. Acontece diretamente com o cliente e usuários finais em um ambiente de homologação. Enquanto as fases de "Design" e "Construção Rápida" validavam protótipos e incrementos a cada ciclo, esta etapa garante que o produto completo soluciona o problema real e atende aos Objetivos Específicos (OE) que motivaram o projeto. É a confirmação que encerra a cadeia de rastreabilidade, autorizando a entrega e o lançamento oficial da solução.

## 5.2 Engenharia de Requisitos e o RAD

| Fases do Processo RAD | Atividades ER | Prática | Técnica | Resultado Esperado |
| :--- | :--- | :--- | :--- | :--- | 
| Planejamento de Requisitos | Elicitação e Descoberta | Levantamento intensivo de necessidades | Workshops JAD, Entrevistas e Brainstorming | Escopo preliminar, funcionalidades mapeadas e objetivos alinhados com stakeholders. |
| | Análise e Consenso | Definição de Escopo, Prioridade e Esforço Técnico | Priorização MoSCoW, Matriz Avaliação Técnica × Valor de Negócio (Planning Poker auxiliar)| Requisitos críticos (Must have) priorizados, avaliados e acordados para o primeiro protótipo |
| | Declaração de Requisitos | Registro Inicial de Requisitos | Temas, Épicos, User Stories, Critérios de Aceitação, DoR e DoD | Backlog inicial estruturado com histórias focadas nas necessidades do usuário, com políticas de entrada e saída definidas. |
| | Verificação e Validação | V&V Contínua e Iterativa | Alinhamento contínuo com stakeholders | Requisitos estruturalmente corretos e validados quanto ao atendimento das necessidades de negócio desde o início. |
| | Organização e Atualização | Estruturação de Rastreabilidade | Matriz de Rastreabilidade (OE - CP - requisito - critério - protótipo - validação - entrega) | Cadeia de rastreabilidade explícita garantindo coerência entre objetivos específicos e entregas. |
| Design do Usuário (Prototipagem Iterativa) | Análise e Consenso | Negociação Contínua com Stakeholders | Trade-offs entre usabilidade e viabilidade técnica | Definição clara das funcionalidades que farão parte do protótipo atual. |
| | Declaração de Requisitos | Refinamento de Histórias | Atualização contínua de histórias de usuário e critérios de aceitação | Histórias refinadas e ajustadas conforme interações com protótipos. |
| | Representação de Requisitos | Criação de Interfaces Visuais | Prototipagem Rápida (Wireframes e Mockups) | Protótipos de interface e fluxos navegáveis desenvolvidos iterativamente para avaliação visual do cliente. |
| | Verificação e Validação | Avaliação com Stakeholders | Validação de Protótipos com o Cliente | Confirmação visual de que o design atende às histórias de usuário e necessidades reais antes da codificação. |
| | Elicitação e Descoberta | Refinamento Iterativo | Sessões JAD Contínuas | Novos requisitos ou ajustes detalhados a partir da interação visual do cliente com os protótipos. |
| Construção Rápida (Iterativa) | Organização e Atualização | Manutenção Contínua do Backlog | Gerenciamento e Refinamento de Backlog (Grooming) | Histórias de usuário detalhadas, estimadas e ajustadas no backlog (DEEP) conforme mudanças da fase de design. |
| | Verificação e Validação | Verificação Técnica | Revisão de Critérios de Aceitação, Checklists e Definition of Done (DoD) | Incremento de software construído rapidamente verificado quanto à correção, consistência e testabilidade. |
| Transição (Cutover) | Verificação e Validação | Homologação Final | Validação Final (Teste de Aceitação pelo Cliente - UAT / Homologação) | Produto consolidado validado no ambiente de homologação com aprovação para lançamento oficial. |
