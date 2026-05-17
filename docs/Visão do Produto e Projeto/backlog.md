# Backlog

O backlog do produto é uma lista ordenada e dinâmica de todas as funcionalidades, melhorias e correções necessárias para o desenvolvimento da solução. Ele serve como a principal fonte de requisitos para a equipe, sendo constantemente refinado à medida que o entendimento sobre o projeto evolui e novos feedbacks do cliente são coletados. No contexto do processo RAD, o backlog é essencial para garantir que as iterações foquem no que gera maior valor de negócio e impacto social imediato.

## 10.1 Backlog Geral

## 10.2 Priorização do Backlog Geral e MVP

Para a priorização do backlog foram utilizados os seguintes critérios:

- PT: Pontuação Técnica (1 a 4)
- VN: Valor de Negócio (1 a 4)

Estes critérios são utilizados para calcular um Coeficiente de Priorização (P), calculado com a fórmula abaixo:

$$
P = \frac{VN}{PT}
$$

Este coeficiente é usado para determinar a prioridade de um requisito baseado no seguinte quadro:

| Coeficiente de Priorização | Prioridade |
| :------------------------: | :--------: |
|           P > 2            |    Alta    |
|         1 < P ≤ 2          |   Média    |
|           P ≤ 1            |   Baixa    |

### 1. Pontuação Técnica

Representa o custo técnico de um requisito, é calculado com base em duas components: Complexidade (C) e Esforço (F), utilizando a fórmula abaixo:

$$
PT = \frac{C + F}{2}
$$

A Complexidade foi derivada dos valores coletados durante uma sessão de Planning Poker feita pela equipe, seguindo este quadro de tradução:

| Intervalo Planning Poker | Complexidade |
| :----------------------: | :----------: |
|           1-3            |      1       |
|            5             |      2       |
|           8-21           |      3       |
|          34-55           |      4       |

O Esforço foi calculado utilizando a média dos esforços atribuídos por cada membro da equipe a cada requisito, com os valores variando entre 1 e 4.

### 2. Valor de Negócio

Representa o valor que cada requisito agrega ao produto, na visão do cliente. O valor de negócio de cada requisito foi atribuído traduzindo a priorização MoSCoW de cada requisito para um número utilizando o quadro abaixo:

|    MoSCoW     | Valor de Negócio |
| :-----------: | :--------------: |
| _Won't Have_  |        1         |
| _Could Have_  |        2         |
| _Should Have_ |        3         |
|  _Must Have_  |        4         |

### 3. Matriz Avaliação Técnica × Valor de Negócio

Abaixo está uma matriz visual mostrando a disposição dos requisitos baseado na sua pontuação técnica e seu valor de negócio, também está delimitado o MVP proposto pela equipe e aprovado pelos stakeholders.

<iframe width="768" height="496" src="https://miro.com/app/live-embed/uXjVHT_JmM8=/?focusWidget=3458764647487987076&embedMode=view_only_without_ui&embedId=195967925908" frameborder="0" scrolling="no" allow="fullscreen; clipboard-read; clipboard-write" allowfullscreen></iframe>
