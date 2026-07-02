# Backlog do Produto

O backlog do produto é uma lista dinâmica das funcionalidades, melhorias e correções da solução. Como principal fonte de requisitos da equipe, ele é continuamente refinado conforme o entendimento do projeto evolui e novos feedbacks dos clientes são obtidos. No contexto do processo RAD, esse artefato orienta as iterações para maximizar o valor de negócio e o impacto social gerado pelo produto.


## 10.1 Backlog Geral

A presente seção detalha o Backlog Geral do produto, organizado a partir da visão orientada a valor em Temas, Épicos e Histórias de Usuário.

> **Nota sobre a Elicitação das Histórias de Usuário:** Em alinhamento com as práticas do método RAD, as Histórias de Usuário apresentadas neste backlog não constituem transcrições literais das falas do cliente. Elas foram formuladas, interpretadas e estruturadas pela equipe técnica com base nas dores e necessidades mapeadas durante os workshops e entrevistas, sendo continuamente validadas e refinadas com os stakeholders ao longo dos ciclos de prototipagem.

### Visão Estrutural do Backlog

Antes do detalhamento granular, apresenta-se a síntese arquitetural do escopo do produto. A estrutura macro está dividida em Temas centrais de negócio, que se desdobram em Épicos e totalizam as Histórias de Usuário (US) mapeadas nesta versão preliminar:

| Tema | Épicos Abrangidos | Quantidade de Histórias (US) |
| :--- | :--- | :---: |
| Gestão de Alunos | • Cadastro e Manutenção de Dados Cadastrais | 3 |
| Gestão de Turmas | • Criação e Manutenção de Turmas<br>• Matrículas e Participação em Turmas | 5 |
| Controle de Frequência e Evasão | • Registro de Presença em Aula<br>• Monitoramento e Prevenção à Evasão | 5 |
| Estoque Solidário de Kimonos | • Controle de Inventário<br>• Empréstimos e Devoluções | 4 |
| Acompanhamento Pedagógico e Engajamento | • Engajamento com a Comunidade<br>• Registros e Observações Pedagógicas<br>• Evolução e Impacto Social | 7 |
| Gestão de Campeonatos | • Configuração de Eventos Competitivos<br>• Participação dos Alunos em Competições | 4 |
| Gestão de Usuários e Acessos | • Cadastro e Manutenção de Voluntários<br>• Controle de Acesso e Segurança | 4 |
|  **Total:**<br><br>**7 Temas** | <br><br>**14 Épicos** | <br><br>**32 US** |

---

### Especificação das Histórias de Usuário

=== "Tema: Gestão de Alunos"

    #### Épico: Cadastro e Manutenção de Dados Cadastrais

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-01 | Como **Coordenador**, quero registrar dados de alunos, para reduzir a dependência de fichas de papel. | [RF01](requisitosDeSoftware.md#rf01) | - |
    | US-02 | Como **Coordenador**, quero editar e buscar dados de alunos, para manter o cadastro sempre atualizado e localizar registros com facilidade. | [RF02](requisitosDeSoftware.md#rf02), [RF05](requisitosDeSoftware.md#rf05) | - |
    | US-03 | Como **Coordenador**, quero inativar ou reativar o cadastro de um aluno, para controlar quem está ativo no projeto sem perder o histórico registrado. | [RF03](requisitosDeSoftware.md#rf03), [RF04](requisitosDeSoftware.md#rf04) | - |

=== "Tema: Gestão de Turmas"

    #### Épico: Criação e Manutenção de Turmas

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-04 | Como **Coordenador**, quero criar e editar turmas com dias e horários, para organizar a grade do projeto. | [RF06](requisitosDeSoftware.md#rf06), [RF07](requisitosDeSoftware.md#rf07) | - |
    | US-05 | Como **Coordenador**, quero encerrar turmas inativas, ou reativar turmas preservando o histórico de aulas e alunos, para manter a memória do que o projeto realizou. | [RF08](requisitosDeSoftware.md#rf08), [RF09](requisitosDeSoftware.md#rf09) | - |
    | US-06 | Como **Voluntário**, quero filtrar turmas por dia ou horário, para localizar rapidamente a turma desejada. | [RF10](requisitosDeSoftware.md#rf10) | - |

    #### Épico: Matrículas e Participação em Turmas

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-07 | Como **Coordenador**, quero matricular um aluno em uma turma, para que ele apareça nas listas de chamada corretas. | [RF11](requisitosDeSoftware.md#rf11) | - |
    | US-08 | Como **Coordenador**, quero cancelar a matrícula de um aluno em uma turma, para que a chamada reflita apenas quem frequenta ativamente. | [RF12](requisitosDeSoftware.md#rf12) | - |

=== "Tema: Controle de Frequência e Evasão"

    #### Épico: Registro de Presença em Aula

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-09 | Como **Voluntário**, quero registrar a presença dos alunos de forma ágil, para fechar a chamada ainda durante a aula. | [RF13](requisitosDeSoftware.md#rf13) | [RNF02](requisitosDeSoftware.md#rnf02) |
    | US-10 | Como **Voluntário**, quero corrigir um registro de presença lançado, para manter o histórico de frequência em conformidade. | [RF14](requisitosDeSoftware.md#rf14) | - |
    | US-11 | Como **Voluntário**, quero registrar o conteúdo trabalhado em cada aula, para manter um diário pedagógico da turma. | [RF16](requisitosDeSoftware.md#rf16) | - |

    #### Épico: Monitoramento e Prevenção à Evasão

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-12 | Como **Coordenador**, quero consultar o histórico de presença do aluno para acompanhar sua frequência contínua e identificar faltas recorrentes. | [RF15](requisitosDeSoftware.md#rf15) | - |
    | US-13 | Como **Coordenador**, quero acompanhar alertas visuais de alunos faltantes diretamente no painel principal, para agir de forma proativa junto às famílias antes que o aluno abandone o projeto. | [RF17](requisitosDeSoftware.md#rf17) | [RNF08](requisitosDeSoftware.md#rnf08) |

=== "Tema: Estoque Solidário de Kimonos"

    #### Épico: Controle de Inventário

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-14 | Como **Coordenador**, quero registrar doações de kimonos e consultar o estoque disponível, para manter o estoque sempre atualizado. | [RF18](requisitosDeSoftware.md#rf18), [RF20](requisitosDeSoftware.md#rf20) | [RNF05](requisitosDeSoftware.md#rnf05) |
    | US-15 | Como **Coordenador**, quero registrar a perda ou dano em kimonos, para que o estoque reflita apenas o que pode ser emprestado. | [RF19](requisitosDeSoftware.md#rf19) | [RNF05](requisitosDeSoftware.md#rnf05) |

    #### Épico: Empréstimos e Devoluções

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-16 | Como **Coordenador**, quero registrar o empréstimo de um kimono a um aluno, para saber onde cada uniforme está a qualquer momento. | [RF21](requisitosDeSoftware.md#rf21) | [RNF05](requisitosDeSoftware.md#rnf05) |
    | US-17 | Como **Coordenador**, quero registrar a devolução de um kimono, para reintegrá-lo ao estoque disponível para empréstimo. | [RF22](requisitosDeSoftware.md#rf22) | [RNF05](requisitosDeSoftware.md#rnf05) |

=== "Tema: Acompanhamento Pedagógico e Engajamento"

    #### Épico: Engajamento com a Comunidade

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-18 | Como **Voluntário**, quero ver no dashboard os aniversariantes da semana, para que a equipe celebre com os alunos no treino. | [RF29](requisitosDeSoftware.md#rf29) | [RNF01](requisitosDeSoftware.md#rnf01) |
    | US-19 | Como **Voluntário**, quero registrar orientações passadas aos responsáveis de um aluno, para manter o histórico claro das conversas realizadas. | [RF25](requisitosDeSoftware.md#rf25) | - |

    #### Épico: Registros e Observações Pedagógicas

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-20 | Como **Voluntário**, quero registrar e editar observações sobre o desenvolvimento de um aluno, para que toda a equipe acompanhe sua trajetória de forma integrada. | [RF23](requisitosDeSoftware.md#rf23), [RF24](requisitosDeSoftware.md#rf24) | - |
    | US-21 | Como **Voluntário**, quero navegar pelos registros pedagógicos de um aluno em ordem cronológica, para acompanhar como seu desenvolvimento evoluiu no projeto. | [RF26](requisitosDeSoftware.md#rf26) | - |

    #### Épico: Evolução e Impacto Social

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-22 | Como **Coordenador**, quero visualizar a trajetória de faixas e graduações de cada aluno, para reconhecer formalmente sua evolução no jiu-jitsu. | [RF28](requisitosDeSoftware.md#rf28) | - |
    | US-23 | Como **Coordenador**, quero gerar e exportar um relatório de impacto social dos alunos, para apresentar resultados à comunidade e a potenciais doadores. | [RF27](requisitosDeSoftware.md#rf27) | - |

=== "Tema: Gestão de Campeonatos"

    #### Épico: Configuração de Eventos Competitivos

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-24 | Como **Coordenador**, quero cadastrar e editar campeonatos com nome, data e local, para registrar os eventos que o projeto disputa. | [RF30](requisitosDeSoftware.md#rf30), [RF31](requisitosDeSoftware.md#rf31) | - |
    | US-25 | Como **Coordenador**, quero encerrar um campeonato preservando participantes e registros, para manter o histórico fiel das competições realizadas. | [RF32](requisitosDeSoftware.md#rf32) | - |

    #### Épico: Participação dos Alunos em Competições

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-26 | Como **Coordenador**, quero inscrever um aluno em um campeonato, para registrar formalmente sua participação no evento. | [RF33](requisitosDeSoftware.md#rf33) | - |
    | US-27 | Como **Coordenador**, quero retirar a inscrição de um aluno de um campeonato, para que apenas participantes confirmados estejam registrados. | [RF34](requisitosDeSoftware.md#rf34) | - |

=== "Tema: Gestão de Usuários e Acessos"

    #### Épico: Cadastro e Manutenção de Voluntários

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-28 | Como **Coordenador**, quero cadastrar e editar voluntários com senhas protegidas, para manter os perfis da equipe sempre atualizados e seguros. | [RF35](requisitosDeSoftware.md#rf35), [RF36](requisitosDeSoftware.md#rf36) | [RNF07](requisitosDeSoftware.md#rnf07) |
    | US-29 | Como **Coordenador**, quero gerenciar o status de atividade dos voluntários (inativar ou reativar), para controlar quem tem acesso ao sistema sem perder o histórico de suas ações. | [RF37](requisitosDeSoftware.md#rf37), [RF38](requisitosDeSoftware.md#rf38) | [RNF04](requisitosDeSoftware.md#rnf04) |
    | US-30 | Como **Coordenador**, quero buscar voluntários por nome, para localizar rapidamente qualquer colaborador sem percorrer toda a listagem. | [RF39](requisitosDeSoftware.md#rf39) | - |

    #### Épico: Controle de Acesso e Segurança

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-31 | Como **Voluntário**, quero realizar o login com minhas credenciais, para acessar as funcionalidades protegidas e restritas ao meu perfil de forma segura. | [RF40](requisitosDeSoftware.md#rf40) | [RNF04](requisitosDeSoftware.md#rnf04) |
    | US-32 | Como **Voluntário**, quero encerrar minha sessão ao terminar o uso, para impedir acessos indevidos pelo meu dispositivo. | [RF41](requisitosDeSoftware.md#rf41) | - |

---

> **Nota:** Os Requisitos Não Funcionais transversais **RNF03** (LGPD), **RNF06** (Responsividade) e **RNF09** (Dark Mode), que representam restrições de todo o sistema, não foram descritos como Histórias de Usuário individuais. Eles atuam como restrições arquiteturais e compõem a **Definition of Done (DoD)** que baliza o desenvolvimento de todas as histórias.

---

---

### 10.2 Árvore de Rastreabilidade Backlog

![Árvore de Rastreabilidade](../assets/arvoreBacklog.jpg){ width="800" }
**Figura 5:** Árvore de Rastreabilidade. Fonte: Elaborada por Júlia Gabriella

Disponível em: [Árvore de Rastreabilidade Backlog](https://www.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/SVAdS-FIGJAM?node-id=297-615&p=f&t=1atgk2CdgQM7cyIf-0)

---