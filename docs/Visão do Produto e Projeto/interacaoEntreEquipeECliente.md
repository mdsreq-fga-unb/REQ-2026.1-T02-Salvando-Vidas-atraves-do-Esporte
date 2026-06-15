# Interação Entre Equipe e Cliente

## 7.1 Composição da Equipe

| Papel | Descrição resumida | Responsável | Participantes |
| --- | --- | --- | --- |
| Gerente de Projeto | Coordena o projeto, garante a comunicação entre cliente e equipe, controla prazos e entregas. | Júlia Siqueira | X |
| Desenvolvedor Frontend | Responsável pela interface do usuário, design e implementação das funcionalidades no lado do cliente. | Giovani de Oliveira | Pedro Lucas e Pedro Ramos |
| Desenvolvedor Backend | Implementa a lógica de negócios, integração com banco de dados e APIs. | José Augusto | Júlia Siqueira e Lucas Oliveira |
| Analista de QA | Garante a qualidade do produto, executando testes de funcionalidade, performance e usabilidade. | Pedro Lucas | X |
| Analista de Requisitos | Define os requisitos funcionais e não funcionais do sistema e garante que eles sejam atendidos. | Lucas Oliveira | Giovani de Oliveira; José Augusto; Júlia Siqueira; Pedro Lucas |

---

## 7.2 Comunicação

Para garantir o alinhamento contínuo da equipe e o cumprimento dos prazos, estabelecemos uma rotina de comunicação estruturada em interações internas e externas, utilizando ferramentas que favorecem a transparência e a rastreabilidade do processo.

- **Comunicação Interna e Alinhamento:** A equipe mantém reuniões presenciais semanais, realizadas às terças e/ou quintas-feiras após o horário das aulas, com o objetivo de discutir o progresso das tarefas, sincronizar o estado do backlog e resolver impedimentos. Para comunicações rápidas, avisos e discussões do dia a dia, o grupo no WhatsApp serve como canal de contato imediato entre os membros.

- **Gestão de Tarefas e Design:** O fluxo de trabalho é centralizado no GitHub Projects, onde as demandas são distribuídas, monitoradas e atualizadas a cada ciclo. O Figma é utilizado como ferramenta de prototipação iterativa, permitindo que todos os membros visualizem, revisem e validem a interface da solução de forma colaborativa antes do desenvolvimento técnico.

- **Comunicação com o Cliente:** O contato direto com o cliente é estruturado em duas cadências complementares:

    1. **Validações Contínuas (semanais ou sob demanda):** Realizadas preferencialmente de forma **presencial**, são interações focadas em refinar detalhes de requisitos, alinhar protótipos iniciais e esclarecer dúvidas que surjam no fluxo corrente de desenvolvimento. Garantem que pequenos desvios sejam corrigidos antes de avançar para o próximo incremento.

    2. **Reuniões de Consolidação (quinzenais):** Realizadas de forma **remota (via Google Meet)**, são encontros mais estruturados destinados a validar incrementos funcionais robustos, revisar o backlog priorizado e fechar formalmente o ciclo de iteração do RAD. São os momentos em que o cliente interage diretamente com as entregas do ciclo e fornece feedback consolidado para orientar a próxima iteração.

> **Nota sobre adaptabilidade:** As datas, frequências e formatos descritos acima não são engessados. Eles podem sofrer alterações e variar dependendo das necessidades do projeto, do fluxo do desenvolvimento e da disponibilidade do cliente. Essa flexibilidade é intencional e reflete a natureza adaptativa do nosso processo, alinhada aos princípios do RAD.

---

## 7.3 Processo de Validação

Seguindo a metodologia RAD, o processo de validação é estruturado em ciclos rápidos de construção e feedback, nos quais o cliente participa ativamente da evolução do produto. A abordagem iterativa garante que desvios sejam identificados e corrigidos o quanto antes, aumentando o alinhamento entre a solução e as expectativas do cliente ao longo de todo o projeto.

### Artefatos Validados pelo Cliente

A validação não se restringe ao produto final. O cliente é envolvido na revisão de artefatos concretos em diferentes momentos do ciclo de desenvolvimento:

- **Backlog do Produto:** O cliente valida o escopo geral do projeto de forma colaborativa, participando da priorização dos itens que compõem o backlog. Nesse processo, avalia quais funcionalidades geram mais valor para o negócio, contribuindo diretamente para a definição do que será construído em cada iteração.

- **Protótipos Evolutivos (Wireframes e Mockups):** Artefato central do ciclo de validação visual no RAD. Os protótipos são construídos iterativamente no Figma e apresentados ao cliente a cada ciclo, permitindo que ele valide se a interface proposta reflete corretamente os fluxos reais de uso antes que qualquer linha de código seja escrita. O feedback obtido nessas sessões orienta diretamente os refinamentos das histórias de usuário e dos critérios de aceitação associados.

- **Histórias de Usuário:** São validadas por meio de conversas diretas e interações estruturadas com o cliente, nas quais a equipe apresenta sua compreensão da necessidade mapeada e o cliente confirma — ou corrige — se o entendimento está correto. Esse processo de construção de sentido compartilhado reduz o risco de desenvolvimento baseado em premissas incorretas.

- **Critérios de Aceitação:** São elaborados pela equipe para tornar cada história de usuário objetivamente testável. O cliente os valida de forma contínua e iterativa a cada ciclo do RAD, interagindo com os protótipos e incrementos funcionais e confirmando na prática se as condições definidas estão sendo atendidas. Esse processo acumulativo de validações parciais culmina naturalmente na homologação final das entregas, quando o produto consolidado é avaliado em sua totalidade.

### Priorização de Mudanças

Em um processo iterativo, mudanças de escopo e ajustes de requisitos são eventos esperados, não exceções. Para que sejam tratadas de forma estruturada e transparente, a equipe adota um fluxo de priorização baseado em negociação contínua, organizado em três passos:

1. **Visão do Cliente:** O cliente solicita a mudança e, em conjunto com a equipe, discute a urgência e o valor de negócio do item. Essa conversa segue a lógica do MoSCoW, classificando a mudança pelo nível de necessidade para o projeto e para os usuários finais.

2. **Visão da Equipe:** A equipe avalia internamente o esforço técnico e a complexidade de implementação da mudança, por meio de estimativas ágeis realizadas colaborativamente (Planning Poker). Esse passo garante que a perspectiva técnica seja considerada antes de qualquer compromisso de entrega.

3. **Consenso:** Equipe e cliente cruzam as duas visões por meio da Matriz de Avaliação Técnica × Valor de Negócio, decidindo juntos se a mudança entra no ciclo atual de desenvolvimento ou é registrada no backlog para uma iteração futura. Esse processo de negociação transparente mantém os ciclos de construção focados e sustentáveis.
