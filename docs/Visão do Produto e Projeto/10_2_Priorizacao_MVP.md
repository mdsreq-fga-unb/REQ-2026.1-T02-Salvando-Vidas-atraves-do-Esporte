## 10.2 Priorização do Backlog Geral e MVP

Para a priorização do backlog foram utilizados os seguintes critérios:

- PT: Pontuação Técnica (1 a 4)
- VN: Valor de Negócio (1 a 4)

**1. Pontuação Técnica**

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

**2. Valor de Negócio**

Representa o valor que cada requisito agrega ao produto, na visão do cliente. O valor de negócio de cada requisito foi atribuído traduzindo a priorização MoSCoW de cada requisito para um número utilizando o quadro abaixo:

|    MoSCoW     | Valor de Negócio |
| :-----------: | :--------------: |
| _Won't Have_  |        1         |
| _Could Have_  |        2         |
| _Should Have_ |        3         |
|  _Must Have_  |        4         |

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

A partir disso foi gerado o quadro abaixo e a matriz visual logo após.

| Requisito |   US Relacionado    | Nome                                                                                                   | PT  | VN  |  P  | Prioridade |
| :-------: | :-----------------: | :----------------------------------------------------------------------------------------------------- | :-: | :-: | :-: | :--------- |
|   RF20    |        US15         | Consultar estoque disponível                                                                           | 1,4 | 4,0 | 2,8 | Alta       |
|   RF01    |        US01         | Cadastrar aluno e responsáveis                                                                         | 1,5 | 4,0 | 2,6 | Alta       |
|   RF02    |        US02         | Editar dados cadastrais                                                                                | 1,5 | 4,0 | 2,6 | Alta       |
|   RF04    |        US01         | Buscar dados cadastrais                                                                                | 1,5 | 4,0 | 2,6 | Alta       |
|   RF05    |        US03         | Vincular responsável ao aluno                                                                          | 1,5 | 4,0 | 2,6 | Alta       |
|   RF06    |        US04         | Desvincular responsável ao aluno                                                                       | 1,5 | 4,0 | 2,6 | Alta       |
|   RF07    |        US05         | Cadastrar turma                                                                                        | 1,5 | 4,0 | 2,6 | Alta       |
|   RF08    |        US05         | Editar turma                                                                                           | 1,5 | 4,0 | 2,6 | Alta       |
|   RF13    |        US10         | Registrar presença em aula                                                                             | 1,5 | 4,0 | 2,6 | Alta       |
|   RNF09   |        US30         | Senhas armazenadas com criptografia AES256                                                             | 1,5 | 4,0 | 2,6 | Alta       |
|   RF09    |        US06         | Inativar turma                                                                                         | 1,2 | 3,0 | 2,5 | Alta       |
|   RF18    |        US15         | Cadastrar doação de kimonos                                                                            | 1,6 | 4,0 | 2,5 | Alta       |
|   RF30    |        US19         | Listar alunos aniversariantes                                                                          | 1,6 | 4,0 | 2,5 | Alta       |
|   RF11    |        US08         | Vincular aluno à turma                                                                                 | 1,3 | 3,0 | 2,3 | Alta       |
|   RF12    |        US09         | Desvincular aluno da turma                                                                             | 1,3 | 3,0 | 2,3 | Alta       |
|   RF16    |        US13         | Consultar histórico de presença                                                                        | 1,4 | 3,0 | 2,1 | Alta       |
|   RF17    |        US14         | Listar alunos em risco de evasão                                                                       | 1,9 | 4,0 | 2,1 | Alta       |
|   RF03    |        US02         | Inativar cadastro                                                                                      | 1,5 | 3,0 | 2,0 | Alta       |
|   RF36    |        US30         | Cadastrar usuário voluntário                                                                           | 1,5 | 3,0 | 2,0 | Alta       |
|   RF37    |        US30         | Editar dados do usuário voluntário                                                                     | 1,5 | 3,0 | 2,0 | Alta       |
|   RF38    |        US31         | Inativar usuário voluntário                                                                            | 1,5 | 3,0 | 2,0 | Alta       |
|   RNF10   |        US14         | Indicadores atualizados em menos de 3 segundos                                                         | 2,0 | 4,0 | 2,0 | Alta       |
|   RF21    |        US17         | Vincular empréstimo do kimono                                                                          | 2,1 | 4,0 | 1,9 | Média      |
|   RF22    |        US18         | Desvincular devolução do kimono                                                                        | 2,1 | 4,0 | 1,9 | Média      |
|   RF40    |        US33         | Encerrar sessão de usuário                                                                             | 1,7 | 3,0 | 1,8 | Média      |
|   RF15    |        US11         | Editar registro de presença                                                                            | 1,9 | 3,0 | 1,6 | Média      |
|   RF19    |        US16         | Inativar kimonos danificados                                                                           | 1,8 | 3,0 | 1,6 | Média      |
|   RNF01   |        US19         | Dashboard deve apresentar as informações essenciais em até três cliques                                | 2,4 | 4,0 | 1,6 | Média      |
|   RNF03   |        US19         | O sistema deve exibir alertas de alunos aniversariantes da semana em até 3 segundos após login         | 2,5 | 3,0 | 1,6 | Média      |
|   RNF04   |        US10         | Registro de presença deve ser feito em menos de um segundo                                             | 1,9 | 4,0 | 1,6 | Média      |
|   RF10    |        US07         | Buscar turmas                                                                                          | 1,3 | 2,0 | 1,5 | Média      |
|   RNF06   |        US32         | Apenas usuários autenticados podem acessar o sistema                                                   | 2,6 | 4,0 | 1,5 | Média      |
|   RF32    |        US26         | Editar campeonato                                                                                      | 1,4 | 2,0 | 1,4 | Média      |
|   RNF02   |        US14         | O sistema deve exibir alerta de risco de evasão quando um aluno tiver 2 semanas de faltas consecutivas | 2,8 | 4,0 | 1,4 | Média      |
|   RNF05   |        ----         | Proteção de dados sensíveis e conformidade com a LGPD                                                  | 2,8 | 4,0 | 1,4 | Média      |
|   RF34    |        US28         | Vincular aluno de um campeonato                                                                        | 1,5 | 2,0 | 1,3 | Média      |
|   RF35    |        US29         | Desvincular aluno de um campeonato                                                                     | 1,5 | 2,0 | 1,3 | Média      |
|   RNF07   | US15 US16 US17 US18 | Registro de auditoria (Logs) de estoque                                                                | 2,3 | 3,0 | 1,3 | Média      |
|   RF39    |        US34         | Buscar usuários voluntários                                                                            | 1,6 | 2,0 | 1,2 | Média      |
|   RF41    |        US32         | Gerenciar níveis de acesso dos usuários                                                                | 2,5 | 3,0 | 1,2 | Média      |
|   RNF08   |        ----         | Interface responsiva e adaptável a múltiplos dispositivos                                              | 1,8 | 2,0 | 1,1 | Média      |
|   RF31    |        US26         | Cadastrar campeonato                                                                                   | 1,9 | 2,0 | 1,0 | Média      |
|   RF33    |        US27         | Inativar campeonato                                                                                    | 1,9 | 2,0 | 1,0 | Média      |
|   RF14    |        US12         | Registrar ocorrências da aula                                                                          | 2,5 | 2,0 | 0,8 | Baixa      |
|   RF23    |        US21         | Registrar observações pedagógicas                                                                      | 3,5 | 3,0 | 0,8 | Baixa      |
|   RF29    |        US24         | Exibir histórico de faixas                                                                             | 3,0 | 2,0 | 0,7 | Baixa      |
|   RF24    |        US20         | Registrar orientações aos responsáveis                                                                 | 3,6 | 2,0 | 0,5 | Baixa      |
|   RF25    |        US23         | Editar registros pedagógicos                                                                           | 4,0 | 2,0 | 0,5 | Baixa      |
|   RF26    |        US23         | Vincular registros pedagógicos ao aluno                                                                | 4,0 | 2,0 | 0,5 | Baixa      |
|   RF27    |        US22         | Visualizar orientações e observações pedagógicas                                                       | 4,0 | 2,0 | 0,5 | Baixa      |
|   RF28    |        US25         | Gerar relatório social                                                                                 | 4,0 | 1,0 | 0,2 | Baixa      |

Abaixo está uma matriz visual mostrando a disposição dos requisitos baseado na sua pontuação técnica e seu valor de negócio, também está delimitado o MVP proposto pela equipe e aprovado pelos stakeholders.

<iframe width="768" height="496" src="https://miro.com/app/live-embed/uXjVHT_JmM8=/?focusWidget=3458764647487987076&embedMode=view_only_without_ui&embedId=195967925908" frameborder="0" scrolling="no" allow="fullscreen; clipboard-read; clipboard-write" allowfullscreen></iframe>
