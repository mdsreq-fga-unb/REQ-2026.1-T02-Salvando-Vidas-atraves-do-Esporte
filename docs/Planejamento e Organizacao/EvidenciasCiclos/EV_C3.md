# Evidências — Ciclo 3
**Período:** 03/06/2026 a 11/06/2026 <br>
**Histórias trabalhadas:** [US-07](../USsMVP/US-07.md), [US-08](../USsMVP/US-08.md), [US-09](../USsMVP/US-09.md), [US-10](../USsMVP/US-10.md)

---

## Engenharia de Requisitos { #eng-requisitos }

### Gravações e Atas

| Evidência | Descrição |
| :--- | :--- |
| [Gravação 11/06](../../Atas/reunioes.md#reuniao-r8) | Este vídeo registra a validação do MVP com foco na apresentação da identidade visual e dos protótipos de alta fidelidade. Nele, a equipe demonstra a logo oficial e o design detalhado das telas, recebendo sugestões de refinamento visual e de interação por parte dos clientes, que validaram o progresso sem alterações significativas no escopo original. |
| [Ata 11/06](../../Atas/unidade-3.md) | Ata da reunião do dia 11/06/2026 com a validação do MVP com foco na apresentação da identidade visual e dos protótipos de alta fidelidade. |

### Protótipos

=== "Baixa Fidelidade"

    === "US-07"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-07 T1](../../assets/evidencias/c3_baixafid_us07_t1.png) | ![Baixa Fid. US-07 T2](../../assets/evidencias/c3_baixafid_us07_t2.png) |

    === "US-08"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-08 T1](../../assets/evidencias/c3_baixafid_us08_t1.png) | ![Baixa Fid. US-08 T2](../../assets/evidencias/c3_baixafid_us08_t2.png) |

    === "US-09"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-09 T1](../../assets/evidencias/c3_baixafid_us09_t1.png) | ![Baixa Fid. US-09 T2](../../assets/evidencias/c3_baixafid_us09_t2.png) |

    === "US-10"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-10 T1](../../assets/evidencias/c3_baixafid_us10_t1.png) | ![Baixa Fid. US-10 T2](../../assets/evidencias/c3_baixafid_us10_t2.png) |

=== "Mockups"

    === "US-07"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-07 T1](../../assets/evidencias/c3_mockup_us07_t1.png) | ![Mockup US-07 T2](../../assets/evidencias/c3_mockup_us07_t2.png) |

    === "US-08"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-08 T1](../../assets/evidencias/c3_mockup_us08_t1.png) | ![Mockup US-08 T2](../../assets/evidencias/c3_mockup_us08_t2.png) |

    === "US-09"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-09 T1](../../assets/evidencias/c3_mockup_us09_t1.png) | ![Mockup US-09 T2](../../assets/evidencias/c3_mockup_us09_t2.png) |

    === "US-10"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-10 T1](../../assets/evidencias/c3_mockup_us10_t1.png) | ![Mockup US-10 T2](../../assets/evidencias/c3_mockup_us10_t2.png) |

---

## Engenharia de Software { #eng-software }

### Diagramas de Entidade (DER)

=== "US-07"
    ![DER US-07](../../assets/evidencias/c3_der_us07.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar a matrícula de aluno em turma (US-07).

=== "US-08"
    ![DER US-08](../../assets/evidencias/c3_der_us08.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar o cancelamento de matrícula (US-08).

=== "US-09"
    ![DER US-09](../../assets/evidencias/c3_der_us09.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar o registro de presença em aula (US-09).

=== "US-10"
    ![DER US-10](../../assets/evidencias/c3_der_us10.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar a correção de registro de presença (US-10).

---

## Definition of Done { #dod }

### Checklist do Ciclo 3

| Critério do DoD | Evidência | Status |
| :--- | :--- | :---: |
| A funcionalidade atende aos critérios de aceitação? | [Issue #7](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/42)<br>[Issue #8](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/107)<br>[Issue #9](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/43)<br>[Issue #10](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/108) | ✅ |
| O código passou por revisão via Pull Request? | [PR #116](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/pull/116#event-27458732588) | ✅ |
| Os testes automatizados foram executados e passaram? | [PR #116](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/pull/116#event-27458732588) | ✅ |
| Os workflows de build foram executados com sucesso? | [Release v1.0.0](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/releases/tag/v1.0.0) | ✅ |
| A documentação foi atualizada? | [Commit](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte) | ✅ |
| A funcionalidade foi testada e aprovada pelo cliente? | [Gravação](../../Atas/reunioes.md#reuniao-r8) | ✅ |