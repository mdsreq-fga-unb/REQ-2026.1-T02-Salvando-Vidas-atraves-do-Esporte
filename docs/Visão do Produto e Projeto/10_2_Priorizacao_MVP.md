# 10.2 Priorização do Backlog e Definição do MVP

A priorização foi construída a partir do cruzamento entre a **visão técnica da equipe** e a **visão de negócio dos stakeholders**, permitindo identificar de forma visual quais histórias de usuário compõem o MVP.

>  A principal mudança em relação à versão anterior foi a migração da priorização baseada em requisitos funcionais e não funcionais para uma priorização orientada pelas **histórias de usuário (US)**.

---

## 1. Complexidade Técnica — Visão da Equipe

A equipe realizou uma sessão de **Planning Poker**, na qual cada história de usuário recebeu um valor da sequência de Fibonacci. Os valores foram agrupados em quatro níveis de complexidade:

| Planning Poker | Complexidade |
| :------------: | :----------: |
| 1 a 3          | 1            |
| 5              | 2            |
| 8 a 21         | 3            |
| 34 a 55        | 4            |

---

## 2. Valor de Negócio — Visão dos Stakeholders

Os stakeholders participaram de um **workshop JAD adaptado** e utilizaram a técnica **MoSCoW** para classificar as histórias de usuário. As cores foram usadas durante a dinâmica para facilitar a visualização e o consenso:

| Cor | Classificação MoSCoW | Peso |
| :-: | :------------------- | :--: |
| 🔴  | Must Have            | 4    |
| 🟠  | Should Have          | 3    |
| 🟡  | Could Have           | 2    |
| 🟢  | Won't Have           | 1    |

---

## 3. Definição do MVP

O MVP foi definido pelo cruzamento direto entre os dois eixos, sem fórmulas adicionais:

- **Eixo X — Complexidade Técnica** (Planning Poker)
- **Eixo Y — Valor de Negócio** (MoSCoW)

As histórias candidatas ao MVP são aquelas com **menor complexidade técnica (1 ou 2)** e **maior valor de negócio (3 ou 4)**:

|                        | Complexidade 1–2 | Complexidade 3–4 |
| ---------------------- | :--------------: | :--------------: |
| **Valor de negócio 4** | ✅ MVP           | ❌               |
| **Valor de negócio 3** | ✅ MVP           | ❌               |
| **Valor de negócio 2** | ❌               | ❌               |
| **Valor de negócio 1** | ❌               | ❌               |

O MVP foi validado e aprovado tanto pela equipe quanto pelos stakeholders.

---
 
## 4. Evidências
 
- 📋 **Workshop JAD adaptado — Sessão 2 (Miro):** classificação MoSCoW realizada com os stakeholders, com a identificação por cores das histórias de usuário.
  [Acessar quadro no Miro](https://miro.com/app/board/uXjVHWbGQMc=/?share_link_id=537692299700)
- 🃏 **Planning Poker — Tabela de complexidade técnica** (Equipe Na Minha Máquina Funciona):
  [Planilha de resumo das votações](https://docs.google.com/spreadsheets/d/1dQxS_lAYoNAk5GWnPe9KIyS89q93ol7SqFwbwe0jv1Q/edit?gid=1468318094#gid=1468318094) · [Sala de votação — Planning Poker](https://app.planitpoker.com/room/Yysv6ThKtJi3A38aSklnc2ORHxQT7WqR)
---

## 5. Matriz de Avaliação Técnica × Valor de Negócio

A matriz abaixo apresenta a distribuição das histórias de usuário segundo os eixos de complexidade técnica e valor de negócio, com destaque para o quadrante correspondente ao MVP aprovado.

<!--![Matriz MVP](../assets/MatrizMVP.jpg){ width=800 }

**Figura 6:** Matriz MVP. Fonte: Elaborada por Júlia Gabriella-->


<iframe width="768" height="496" src="https://miro.com/app/live-embed/uXjVHT_JmM8=/?focusWidget=3458764647487987076&embedMode=view_only_without_ui&embedId=195967925908" frameborder="0" scrolling="no" allow="fullscreen; clipboard-read; clipboard-write" allowfullscreen></iframe>

