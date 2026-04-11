# Estratégias de Engenharia de Software

## 3.1 Estratégia Priorizada
 
**Abordagem de Desenvolvimento de Software:** Híbrida

**Ciclo de Vida:** Iterativo e Incremental

**Processo de Engenharia de Software:** RAD (Rapid Application Development)

---
 
## 3.2 Quadro Comparativo
 
O quadro a seguir apresenta uma comparação entre o **RAD** e o **Modelo Espiral**, os dois processos são híbridos/adaptativos, a análise a seguir irá permitir uma melhor compreensão e justificativa da escolha que melhor se adapta ao contexto do projeto Salvando Vidas Através do Esporte.
 
| Característica | RAD | Modelo Espiral |
|---|---|---|
| **Abordagem geral** | Enfatiza prototipagem rápida e iterativa como alternativa ao planejamento extensivo, visando acelerar o desenvolvimento de aplicações | Combina elementos do desenvolvimento iterativo com aspectos sistemáticos do modelo cascata, incorporando forte ênfase na análise de riscos |
| **Eixo central do processo** | Velocidade de entrega e iteração com usuários, utilizando prototipação e feedback constante para refinar requisitos | Análise sistemática de riscos como eixo central, permitindo revisões sucessivas e evolução progressiva do produto |
| **Estrutura de fases** | Quatro fases: planejamento de requisitos, design do usuário, construção e cutover (implementação final) | Ciclos em espiral, cada um abrangendo planejamento, análise de riscos, engenharia e avaliação |
| **Gestão de riscos** | Não possui mecanismo formal e central de análise de riscos; riscos são tratados de forma implícita através do feedback contínuo e iterações curtas | Cada ciclo começa identificando objetivos, alternativas e restrições, seguido de avaliação de alternativas e identificação e resolução de riscos de forma explícita |
| **Elicitação de requisitos** | Planejamento inicial de alto nível, sem buscar especificação exaustiva; requisitos emergem e evoluem durante workshops de design e prototipagem | Elicitação progressiva: requisitos são elicitados e refinados através de ciclos sucessivos, podendo começar em alto nível e tornando-se progressivamente mais detalhados |
| **Papel da prototipagem** | Central e obrigatória: protótipos funcionais evoluem progressivamente para o sistema final, servindo simultaneamente como especificação e validação dos requisitos | Utilizada para explorar e validar requisitos de alta incerteza ou risco; desde rascunhos em papel até software funcional |
| **Participação do usuário/cliente** | Participação ativa durante todo o processo, especialmente na fase de design do usuário, com workshops estruturados e ciclos curtos de prototipagem–revisão–refinamento | Requer envolvimento contínuo dos stakeholders para avaliação a cada ciclo, mas com maior formalidade e ênfase em aprovações estruturadas |
| **Documentação** | Mínima e focada: design de interface, fluxos de dados e mapeamentos de banco de dados; criada apenas quando necessária para clareza ou suporte futuro | Evolui ao longo dos ciclos; começa com descrições de alto nível e refina-se progressivamente; nível de formalidade pode ser adaptado conforme os riscos identificados |
| **Organização dos requisitos** | Requisitos de negócio, modelos de interface, modelos de dados e processos (fluxos de trabalho e lógica de negócio) | Objetivos, alternativas, restrições, requisitos incrementais e requisitos baseados em riscos |
| **Flexibilidade para mudanças** | Alta: ciclos curtos permitem ajuste rápido dos requisitos com base em feedback imediato dos stakeholders | Alta: mudanças são incorporadas naturalmente na estrutura cíclica; cada ciclo reavalia objetivos e requisitos |
| **Escala e complexidade adequadas** | Projetos com prazos curtos, requisitos difíceis de articular mas fáceis de visualizar, sistemas de informação com ênfase em interface do usuário e escopo que permite modularização | Projetos grandes, complexos e inovadores com alto grau de incerteza, sistemas críticos onde a análise de riscos é essencial, desenvolvimento sem precedentes |
| **Limitações principais** | Menor adequação para sistemas complexos ou de missão crítica; risco de foco excessivo em interfaces; dependência de comprometimento intenso dos usuários finais; dificuldades com sistemas de grande escala ou alta interoperabilidade com sistemas legados | Necessita expertise significativa em avaliação de riscos; pode ser complexo gerenciar e documentar a evolução dos requisitos; potencialmente mais custoso e demorado; requer envolvimento contínuo e qualificado dos stakeholders |
| **Complexidade de gerenciamento** | Menor: processo mais leve, focado na entrega rápida e na colaboração direta com usuários | Maior: exige expertise em avaliação de riscos e gestão de ciclos, tornando-se mais complexo e dispendioso para gerenciar |
| **Tendências atuais** | Integração com DevOps para entrega contínua; incorporação de ferramentas low-code/no-code; adaptação para mobile-first | Incorporação em frameworks ágeis escalados; aplicação em DevSecOps com ênfase em análise de riscos de segurança; adaptação para IA e sistemas ciber-físicos |
| **Adequação ao projeto Salvando vidas Através do Esporte** | Ideal para o projeto: prazos curtos, sistema de informação com forte componente de interface, requisitos difíceis de articular por usuários com baixo letramento digital mas facilmente visualizáveis via protótipos, equipe pequena e necessidade de validação frequente com o coordenador | Menos adequado: projetado para sistemas de grande porte, alta complexidade e incerteza técnica crítica, o que não corresponde ao perfil do projeto; exigiria expertise em análise de riscos que a equipe não necessariamente possui |
 
---
 
## 3.3 Justificativa
 
O RAD foi escolhido em detrimento do Modelo Espiral por ser o processo que melhor se alinha ao perfil do projeto, da equipe e dos usuários envolvidos. A escolha se fundamenta em quatro argumentos principais:
 
1. **Escopo delimitado e modularizável.** O produto é composto por módulos funcionalmente independentes, como o cadastro de alunos, controle de frequência e gestão de kimonos. Essa estrutura favorece entregas incrementais e isoladas, característica central do RAD, sem a necessidade de ciclos extensos de análise de riscos que o Espiral demandaria.
 
2. **Requisitos difíceis de articular, mas fáceis de visualizar.** O coordenador e os voluntários têm o letramento digital básico e dificuldade em descrever formalmente o que precisam. A prototipagem evolutiva do RAD resolve esse problema diretamente: em vez de tentar especificar requisitos de forma abstrata, os usuários reagem ao que veem, validando ou ajustando o produto a cada iteração.
 
3. **Prazo semestral e equipe reduzida.** O RAD é orientado a entregas rápidas com equipes pequenas, o que é compatível com as restrições do projeto. 
 
4. **Adoção tecnológica como risco central.** O maior risco do projeto não é técnico, mas humano: garantir que voluntários com hábitos manuais consolidados adotem o sistema. O RAD reduz esse risco pela participação ativa dos usuários ao longo de todo o desenvolvimento, aumentando a aderência ao produto final. 
 