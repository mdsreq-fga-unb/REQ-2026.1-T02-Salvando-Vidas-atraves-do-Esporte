# Backlog do Produto

O backlog do produto é uma lista dinâmica das funcionalidades, melhorias e correções da solução. Como principal fonte de requisitos da equipe, ele é continuamente refinado conforme o entendimento do projeto evolui e novos feedbacks dos clientes são obtidos. No contexto do processo RAD, esse artefato orienta as iterações para maximizar o valor de negócio e o impacto social gerado pelo produto.


## 10.1 Backlog Geral

A presente seção detalha o Backlog Geral do produto, organizado a partir da visão orientada a valor em Temas, Épicos e Histórias de Usuário.

> **Nota sobre a Elicitação das Histórias de Usuário:** Em alinhamento com as práticas do método RAD, as Histórias de Usuário apresentadas neste backlog não constituem transcrições literais das falas do cliente. Elas foram formuladas, interpretadas e estruturadas pela equipe técnica com base nas dores e necessidades mapeadas durante os workshops e entrevistas, sendo continuamente validadas e refinadas com os stakeholders ao longo dos ciclos de prototipagem.

### Visão Estrutural do Backlog

Antes do detalhamento granular, apresenta-se a síntese arquitetural do escopo do produto. A estrutura macro está dividida em Temas centrais de negócio, que se desdobram em Épicos e totalizam as Histórias de Usuário (US) mapeadas nesta versão preliminar:

| Tema | Épicos Abrangidos | Quantidade de Histórias (US) |
| :--- | :--- | :---: |
| Gestão de Alunos e Responsáveis | • Cadastro e Manutenção de Dados Cadastrais<br>• Vínculos entre Aluno e Responsável | 5 |
| Gestão de Turmas | • Criação e Manutenção de Turmas<br>• Matrículas e Participação em Turmas | 5 |
| Controle de Frequência e Evasão | • Registro de Presença em Aula<br>• Monitoramento e Prevenção à Evasão | 5 |
| Estoque Solidário de Kimonos | • Controle de Inventário<br>• Empréstimos e Devoluções | 4 |
| Acompanhamento Pedagógico e Engajamento | • Engajamento com a Comunidade<br>• Registros e Observações Pedagógicas<br>• Evolução e Impacto Social | 7 |
| Gestão de Campeonatos | • Configuração de Eventos Competitivos<br>• Participação dos Alunos em Competições | 4 |
| Gestão de Usuários e Acessos | • Cadastro e Manutenção de Voluntários<br>• Controle de Acesso e Segurança | 7 |
|  **Total:**<br><br>**7 Temas** | <br><br>**15 Épicos** | <br><br>**37 US** |

---

### Especificação das Histórias de Usuário

=== "Tema: Gestão de Alunos e Responsáveis"

    #### Épico: Cadastro e Manutenção de Dados Cadastrais

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-01 | Como **Coordenador**, quero registrar e buscar dados de alunos e responsáveis, para reduzir a dependência de fichas de papel. | RF01, RF04 | - |
    | US-02 | Como **Coordenador**, quero editar dados de alunos e responsáveis e inativá-los quando saírem, para manter o cadastro organizado sem apagar o histórico. | RF02, RF03 | - |

    #### Épico: Vínculos entre Aluno e Responsável

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-03 | Como **Coordenador**, quero vincular responsáveis a cada aluno, para saber com quem contatar quando necessário. | RF05 | - |
    | US-04 | Como **Coordenador**, quero remover o vínculo entre aluno e responsável, para manter as informações de tutela sempre atualizadas. | RF06 | - |
    | US-36 | Como **Coordenador**, quero reativar o cadastro de um aluno ou responsável inativado, para que ele retome as atividades no projeto sem que eu precise redigitar todo o seu histórico. | RF42 | - |

=== "Tema: Gestão de Turmas"

    #### Épico: Criação e Manutenção de Turmas

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-05 | Como **Coordenador**, quero criar e editar turmas com dias, horários, faixa etária e professor, para organizar a grade do projeto. | RF07, RF08 | - |
    | US-06 | Como **Coordenador**, quero encerrar turmas inativas, ou reativar turmas preservando o histórico de aulas e alunos, para manter a memória do que o projeto realizou. | RF09, RF44 | - |
    | US-07 | Como **Voluntário**, quero filtrar turmas por dia, horário ou professor, para localizar rapidamente a turma desejada. | RF10 | - |

    #### Épico: Matrículas e Participação em Turmas

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-08 | Como **Coordenador**, quero matricular um aluno em uma turma, para que ele apareça nas listas de chamada corretas. | RF11 | - |
    | US-09 | Como **Coordenador**, quero cancelar a matrícula de um aluno em uma turma, para que a chamada reflita apenas quem frequenta ativamente. | RF12 | - |

=== "Tema: Controle de Frequência e Evasão"

    #### Épico: Registro de Presença em Aula

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-10 | Como **Voluntário**, quero registrar a presença dos alunos de forma ágil, para fechar a chamada ainda durante a aula. | RF13 | RNF03 |
    | US-11 | Como **Voluntário**, quero corrigir um registro de presença lançado errado, para manter o histórico de frequência confiável. | RF15 | - |
    | US-12 | Como **Voluntário**, quero registrar o conteúdo trabalhado em cada aula, para manter um diário pedagógico da turma. | RF14 | - |

    #### Épico: Monitoramento e Prevenção à Evasão

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-13 | Como Coordenador, quero consultar o histórico de frequência para identificar mudanças no padrão de presença antes que virem abandono | RF16 | - |
    | US-14 | Como **Coordenador**, quero ver a lista de alunos com duas semanas seguidas de faltas, para contatar a família antes que a criança abandone o projeto. | RF17 | RNF09 |

=== "Tema: Estoque Solidário de Kimonos"

    #### Épico: Controle de Inventário

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-15 | Como **Coordenador**, quero registrar doações de kimonos e consultar o estoque disponível, para nunca ficar sem uniforme para novos alunos. | RF18, RF20 | RNF06 |
    | US-16 | Como **Coordenador**, quero dar baixa em kimonos danificados, para que o estoque reflita apenas o que pode ser emprestado. | RF19 | RNF06 |

    #### Épico: Empréstimos e Devoluções

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-17 | Como **Coordenador**, quero registrar o empréstimo de um kimono a um aluno, para saber onde cada uniforme está a qualquer momento. | RF21 | RNF06 |
    | US-18 | Como **Coordenador**, quero registrar a devolução de um kimono, para reintegrá-lo ao estoque disponível para empréstimo. | RF22 | RNF06 |

=== "Tema: Acompanhamento Pedagógico e Engajamento"

    #### Épico: Engajamento com a Comunidade

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-19 | Como **Voluntário**, quero ver no dashboard os aniversariantes da semana, para que a equipe celebre com os alunos no treino. | RF29 | RNF01, RNF02 |
    | US-20 | Como **Voluntário**, quero registrar orientações passadas aos responsáveis de um aluno, para manter histórico claro das conversas realizadas. | RF24 | - |

    #### Épico: Registros e Observações Pedagógicas

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-21 | Como **Voluntário**, quero registrar observações sobre o desenvolvimento de um aluno, para que toda a equipe acompanhe sua trajetória de forma integrada. | RF23 | - |
    | US-22 | Como **Voluntário**, quero navegar pelos registros pedagógicos de um aluno em ordem cronológica, para acompanhar como seu desenvolvimento evoluiu no projeto. | RF27 | - |
    | US-23 | Como **Voluntário**, quero corrigir e revincular um registro pedagógico ao aluno correto, para garantir precisão no histórico de cada criança. | RF25 | - |

    #### Épico: Evolução e Impacto Social

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-24 | Como **Coordenador**, quero visualizar a trajetória de faixas e graduações de cada aluno, para reconhecer formalmente sua evolução no jiu-jitsu. | RF28 | - |
    | US-25 | Como **Coordenador**, quero gerar e exportar um relatório de impacto social dos alunos, para apresentar resultados à comunidade e a potenciais doadores. | RF27 | - |

=== "Tema: Gestão de Campeonatos"

    #### Épico: Configuração de Eventos Competitivos

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-26 | Como **Coordenador**, quero cadastrar e editar campeonatos com nome, data e local, para registrar os eventos que o projeto disputa. | RF30, RF31 | - |
    | US-27 | Como **Coordenador**, quero encerrar um campeonato preservando participantes e registros, para manter o histórico fiel das competições realizadas. | RF32 | - |

    #### Épico: Participação dos Alunos em Competições

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-28 | Como **Coordenador**, quero inscrever um aluno em um campeonato, para registrar formalmente sua participação no evento. | RF33 | - |
    | US-29 | Como **Coordenador**, quero retirar a inscrição de um aluno de um campeonato, para que apenas participantes confirmados estejam registrados. | RF34 | - |

=== "Tema: Gestão de Usuários e Acessos"

    #### Épico: Cadastro e Manutenção de Voluntários

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-30 | Como **Coordenador**, quero cadastrar e editar voluntários com senhas protegidas, para manter os perfis da equipe sempre atualizados e seguros. | RF35, RF36 | RNF08 |
    | US-31 | Como **Coordenador**, quero inativar um voluntário preservando seu histórico de ações, para garantir que apenas membros ativos acessem o sistema. | RF37 | - |
    | US-32 | Como **Coordenador**, quero buscar voluntários por nome ou função, para localizar rapidamente qualquer colaborador sem percorrer toda a listagem. | RF38 | - |
    | US-37 | Como Coordenador, quero reativar o perfil de um usuário voluntário, para restaurar rapidamente o seu acesso ao sistema caso ele retorne à equipe do projeto social. | RF43 | RNF05 |

    #### Épico: Controle de Acesso e Segurança

    | ID da US | História de Usuário | RFs Relacionados | RNFs Relacionados |
    | :---: | :--- | :---: | :---: |
    | US-33 | Como **Coordenador**, quero definir o nível de permissão de cada voluntário, para proteger os dados sensíveis dos alunos conforme cada função. | RF43 | - |
    | US-34 | Como **Voluntário**, quero encerrar minha sessão ao terminar o uso, para impedir acessos indevidos pelo meu dispositivo. | RF39 | - |
    | US-35 | Como **Voluntário**, quero realizar o login com minhas credenciais, para acessar as funcionalidades protegidas e restritas ao meu perfil de forma segura. | RF41 | RNF05 |

---


> **Nota:** Os Requisitos Não Funcionais transversais **RNF04** (LGPD), **RNF09** (Responsividade) e **RNF10**    (Dark Mode), que representam restrições de todo o sistema, não foram descritos como Histórias de Usuário individuais. Eles atuam como restrições arquiteturais e compõem a **Definition of Done (DoD)** que baliza o desenvolvimento de todas as histórias.

---

---
 
### 10.2 Árvore de Rastreabilidade Backlog
 
![Árvore de Rastreabilidade](../assets/arvoreBacklog.jpg){ width="800" }
**Figura 5:** Árvore de Rastreabilidade. Fonte: Elaborada por Júlia Gabriella
 
Disponível em: [Árvore de Rastreabilidade Backlog](https://www.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/SVAdS-FIGJAM?node-id=297-615&p=f&t=1atgk2CdgQM7cyIf-0)

---