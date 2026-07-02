# Evidências — Ciclo 2
**Período:** 29/05/2026 a 03/06/2026 <br>
**Histórias trabalhadas:** [US-01](../USsMVP/US-01.md), [US-02](../USsMVP/US-02.md), [US-03](../USsMVP/US-03.md)

---

## Engenharia de Requisitos { #eng-requisitos }

### Gravações e Atas

| Evidência | Descrição |
| :--- | :--- |
| [Gravação 03/06](../../Atas/reunioes.md#reuniao-r7) | Este vídeo apresenta a reunião de priorização do MVP realizada com a técnica MoSCoW e o apoio visual do Miro. Durante a dinâmica, a equipe e os clientes revisaram as histórias de usuário (US-01, US-02, US-03) e decidiram reduzir a prioridade da funcionalidade de criação de turmas para a categoria 'Should', justificando que ela não é essencial para o lançamento inicial por ser um processo pouco frequente. |
| [Ata 03/06](../../Atas/reunioes.md#reuniao-r7) | Ata da reunião do dia 03/06/2026 com a Priorização do MVP utilizando a técnica MoSCoW |

### Protótipos

=== "Baixa Fidelidade"

    === "US-01"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-01 T1](../../assets/evidencias/c2_baixafid_us01_t1.png) | ![Baixa Fid. US-01 T2](../../assets/evidencias/c2_baixafid_us01_t2.png) |

    === "US-02"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-02 T1](../../assets/evidencias/c2_baixafid_us02_t1.png) | ![Baixa Fid. US-02 T2](../../assets/evidencias/c2_baixafid_us02_t2.png) |

    === "US-03"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Baixa Fid. US-03 T1](../../assets/evidencias/c2_baixafid_us03_t1.png) | ![Baixa Fid. US-03 T2](../../assets/evidencias/c2_baixafid_us03_t2.png) |

=== "Mockups"

    === "US-01"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-01 T1](../../assets/evidencias/c2_mockup_us01_t1.png) | ![Mockup US-01 T2](../../assets/evidencias/c2_mockup_us01_t2.png) |

    === "US-02"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-02 T1](../../assets/evidencias/c2_mockup_us02_t1.png) | ![Mockup US-02 T2](../../assets/evidencias/c2_mockup_us02_t2.png) |

    === "US-03"
        | Tela 1 | Tela 2 |
        |:---:|:---:|
        | ![Mockup US-03 T1](../../assets/evidencias/c2_mockup_us03_t1.png) | ![Mockup US-03 T2](../../assets/evidencias/c2_mockup_us03_t2.png) |

---

## Engenharia de Software { #eng-software }

### Diagramas de Entidade (DER)

=== "US-01"
    ![DER US-01](../../assets/evidencias/c2_der_us01.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar o cadastro de alunos (US-01).

=== "US-02"
    ![DER US-02](../../assets/evidencias/c2_der_us02.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar a edição e busca de alunos (US-02).

=== "US-03"
    ![DER US-03](../../assets/evidencias/c2_der_us03.png)

    **Finalidade:** Descreva aqui quais entidades e relacionamentos foram modelados para suportar a inativação e reativação de alunos (US-03).

---

## Definition of Done { #dod }

### Checklist do Ciclo 2

| Critério do DoD | Evidência | Status |
| :--- | :--- | :---: |
| A funcionalidade atende aos critérios de aceitação? | [Issue #1](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/40)<br>[Issue #2](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/106)<br>[Issue #3](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/issues/41) | ✅ |
| O código passou por revisão via Pull Request? | [PR #116](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/pull/116#event-27458732588) | ✅ |
| Os testes automatizados foram executados e passaram? | [PR #116](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/pull/116#event-27458732588) | ✅ |
| Os workflows de build foram executados com sucesso? | [Release v1.0.0](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte/releases/tag/v1.0.0) | ✅ |
| A documentação foi atualizada? | [Commit](https://github.com/mdsreq-fga-unb/REQ-2026.1-T02-Salvando-Vidas-atraves-do-Esporte) | ✅ |
| A funcionalidade foi testada e aprovada pelo cliente? | [Gravação](../../Atas/reunioes.md#reuniao-r7) | ✅ |