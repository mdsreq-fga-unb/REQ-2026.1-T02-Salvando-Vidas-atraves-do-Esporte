# Evidências — Ciclo X
**Período:** DD/MM/AAAA a DD/MM/AAAA
**Histórias trabalhadas:** [US-XX](../USsMVP/US-XX.md), [US-YY](../USsMVP/US-YY.md)

---

## Engenharia de Requisitos { #eng-requisitos }

### Gravações e Atas

| Evidência | Descrição |
| :--- | :--- |
| [📹 Reunião DD/MM](link) | Descreve exatamente o que foi elicitado/validado, com quem e quais USs foram abordadas. |
| [📄 Ata DD/MM](link) | Descreve as decisões tomadas, alinhamentos com o cliente e o que foi aprovado nesta reunião. |

### Protótipos de Baixa Fidelidade e Mockups

=== "US-XX"
    | Tela 1 | Tela 2 |
    |:---:|:---:|
    | ![descrição](../../assets/evidencias/c1_usXX_t1.png) | ![descrição](../../assets/evidencias/c1_usXX_t2.png) |

=== "US-YY"
    | Tela 1 | Tela 2 |
    |:---:|:---:|
    | ![descrição](../../assets/evidencias/c1_usYY_t1.png) | ![descrição](../../assets/evidencias/c1_usYY_t2.png) |

---

## Engenharia de Software { #eng-software }

### Diagramas de Entidade (DER)

=== "US-XX"
    ![DER US-XX](../../assets/evidencias/c1_der_usXX.png)

    **Finalidade:** Descreve brevemente quais entidades e relacionamentos foram modelados para suportar esta história.

=== "US-YY"
    ![DER US-YY](../../assets/evidencias/c1_der_usYY.png)

    **Finalidade:** Descreve brevemente quais entidades e relacionamentos foram modelados para suportar esta história.

---

## Definition of Done { #dod }

### Checklist do Ciclo X

| Critério do DoD | Evidência | Status |
| :--- | :--- | :---: |
| A funcionalidade atende aos critérios de aceitação? | [Issue #XX](link_github) | ✅ |
| O código passou por revisão via Pull Request? | [PR #XX](link_github) | ✅ |
| Os testes automatizados foram executados e passaram? | [Issue #XX](link_github) | ✅ |
| Os workflows de build foram executados com sucesso? | [Release vX.X](link_github) | ✅ |
| A documentação foi atualizada? | [Commit](link_github) | ✅ |
| A funcionalidade foi testada e aprovada pelo cliente? | [Gravação](link) | ✅ |