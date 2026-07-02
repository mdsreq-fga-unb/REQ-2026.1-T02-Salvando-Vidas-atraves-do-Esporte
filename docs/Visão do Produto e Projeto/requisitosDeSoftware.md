# 8 Requisitos de Software

## 8.1 Lista de Requisitos Funcionais

Os requisitos funcionais descrevem as funcionalidades específicas que o sistema deve implementar para atender às necessidades da instituição Salvando Vidas Através do Esporte, realizado pela Segunda Igreja Batista do Recanto das Emas. A seguir, são apresentados o conjunto preliminar de requisitos.

| ID | Nome | Descrição |
| :---: | :--- | :--- |
| <span id="rf01"></span>RF01 | Cadastrar aluno | Permitir a inserção de um novo aluno no sistema, registrando seus dados pessoais e de matrícula. |
| <span id="rf02"></span>RF02 | Editar cadastro do aluno | Permitir a alteração das informações cadastrais de um aluno ou responsável já registrado no sistema. |
| <span id="rf03"></span>RF03 | Inativar cadastro do aluno | Permitir a alteração do status de um aluno, mantendo seu histórico, mas removendo-o das listas ativas. |
| <span id="rf04"></span>RF04 | Reativar cadastro do aluno | Permitir a reativação do status de um aluno previamente inativado, restaurando-o às listas ativas do sistema e reestabelecendo seu vínculo com as informações registradas. |
| <span id="rf05"></span>RF05 | Buscar cadastro do aluno | Permitir a pesquisa dos dados de alunos cadastrados utilizando parâmetros como nome para localizar seus registros. |
| <span id="rf06"></span>RF06 | Cadastrar turma | Permitir a criação de uma nova turma no sistema, registrando detalhes como faixa etária, dias da semana, horários de aula. |
| <span id="rf07"></span>RF07 | Editar turma | Permitir a alteração das informações e configurações de uma turma previamente cadastrada no sistema. |
| <span id="rf08"></span>RF08 | Inativar turma | Permitir a alteração do status de uma turma para inativa, encerrando suas atividades regulares, mas mantendo intacto o histórico de aulas e alunos vinculados. |
| <span id="rf09"></span>RF09 | Reativar turma | Permitir a reativação do status de uma turma previamente inativada, retomando suas atividades regulares no sistema e mantendo o histórico de aulas e alunos vinculados. |
| <span id="rf10"></span>RF10 | Buscar turmas | Permitir a pesquisa e filtragem das turmas cadastradas utilizando parâmetros como dias de aula ou horários para localizar seus registros. |
| <span id="rf11"></span>RF11 | Vincular aluno à turma | Permitir a associação de um aluno a uma turma específica, formalizando sua inscrição e participação nas atividades daquela turma. |
| <span id="rf12"></span>RF12 | Desvincular aluno da turma | Permitir a remoção do vínculo de um aluno com uma turma, cancelando sua inscrição ou participação naquela turma. |
| <span id="rf13"></span>RF13 | Registrar presença em aula | Permitir a marcação de presença para os alunos associados a uma aula ou turma selecionada. |
| <span id="rf14"></span>RF14 | Editar registro de presença | Permitir a retificação do status de frequência de um aluno em uma aula após o lançamento inicial. |
| <span id="rf15"></span>RF15 | Consultar histórico de presença | Permitir a visualização consolidada dos registros de frequência de um aluno ao longo de um período selecionado. |
| <span id="rf16"></span>RF16 | Registrar o conteúdo e as ocorrências gerais da aula | Permitir a descrição das atividades realizadas, temas abordados e eventos relevantes que ocorreram em uma aula registrada no sistema. |
| <span id="rf17"></span>RF17 | Monitorar alunos com risco de evasão | Permitir a sinalização visual de alunos com alta inatividade de frequência. |
| <span id="rf18"></span>RF18 | Registrar doação de kimonos | Permitir a adição de novas unidades de kimonos ao controle de estoque, atualizando a quantidade disponível. |
| <span id="rf19"></span>RF19 | Registrar perda de kimonos | Permitir o registro da remoção de itens do estoque devido a danos ou perda, atualizando o inventário. |
| <span id="rf20"></span>RF20 | Consultar estoque de kimonos | Permitir a verificação da quantidade atualizada de kimonos doados, perdidos, disponíveis e emprestados no inventário. |
| <span id="rf21"></span>RF21 | Registrar empréstimo de kimono | Permitir o registro da saída de um kimono do estoque, vinculando-o a um aluno específico. |
| <span id="rf22"></span>RF22 | Registrar devolução de kimono | Permitir o registro do retorno e desvinculação de um kimono emprestado, reintegrando-o ao estoque disponível no inventário. |
| <span id="rf23"></span>RF23 | Registrar observações pedagógicas | Permitir a inserção de apontamentos sobre o comportamento e desenvolvimento educacional e técnico do aluno. |
| <span id="rf24"></span>RF24 | Editar observações pedagógicas | Permitir a alteração e atualização de observações e registros pedagógicos previamente cadastrados para um aluno. |
| <span id="rf25"></span>RF25 | Registrar orientações aos responsáveis | Permitir a documentação das comunicações, diretrizes, feedbacks e ocorrências repassados aos responsáveis do aluno. |
| <span id="rf26"></span>RF26 | Visualizar orientações e observações pedagógicas | Permitir a exibição cronológica de todas as observações, orientações e registros pedagógicos associados a um aluno. |
| <span id="rf27"></span>RF27 | Gerar relatório social | Permitir a geração, compilação e exportação de um relatório consolidado contendo dados sociais e informações de vulnerabilidade do aluno. |
| <span id="rf28"></span>RF28 | Exibir histórico de faixas | Permitir a visualização do registro cronológico de todas as graduações e exames já realizados pelo aluno. |
| <span id="rf29"></span>RF29 | Listar alunos aniversariantes | Permitir a filtragem e exibição dos alunos que completam ano de vida em período determinado. |
| <span id="rf30"></span>RF30 | Cadastrar campeonato | Permitir o registro e documentação de um novo campeonato ou evento competitivo no qual os alunos da instituição podem participar, incluindo datas e detalhes do evento. |
| <span id="rf31"></span>RF31 | Editar campeonato | Permitir a alteração dos dados de um evento competitivo previamente cadastrado, como modificação de nome, data ou local de realização. |
| <span id="rf32"></span>RF32 | Inativar campeonato | Permitir a alteração do status de um campeonato para inativo (cancelado ou finalizado), preservando os registros de participação passados. |
| <span id="rf33"></span>RF33 | Vincular aluno a um campeonato | Permitir a inscrição e associação de um aluno cadastrado a um campeonato específico, formalizando sua participação e registro no evento. |
| <span id="rf34"></span>RF34 | Desvincular aluno de um campeonato | Permitir a remoção do vínculo de um aluno com um campeonato, cancelando a sua inscrição ou retirando seu registro de participação. |
| <span id="rf35"></span>RF35 | Cadastrar usuário voluntário | Permitir a inserção no sistema dos perfis dos voluntários do projeto. |
| <span id="rf36"></span>RF36 | Editar dados do usuário voluntário | Permitir a alteração das informações pessoais, de contato ou de perfil de um usuário voluntário já registrado no sistema. |
| <span id="rf37"></span>RF37 | Inativar usuário voluntário | Permitir a alteração do status de um usuário voluntário para inativo, revogando seu acesso ao sistema, mas preservando o histórico de sua atuação no projeto. |
| <span id="rf38"></span>RF38 | Reativar usuário voluntário | Permitir a reativação do status de um usuário voluntário previamente inativado, restabelecendo seu acesso ao sistema, mantendo o histórico de atuação anterior. |
| <span id="rf39"></span>RF39 | Buscar usuários voluntários | Permitir a pesquisa dos dados de usuários voluntários utilizando parâmetros como nome para localizar seus perfis e cadastros. |
| <span id="rf40"></span>RF40 | Realizar login (autenticação) | Permitir que usuários cadastrados acessem o sistema mediante validação de credenciais, garantindo que apenas usuários autorizados obtenham acesso às funcionalidades disponíveis conforme seu perfil. |
| <span id="rf41"></span>RF41 | Encerrar sessão de usuário | Permitir que um usuário faça logout do sistema, encerrando sua sessão de forma segura. |


## 8.2 Lista de Requisitos Não Funcionais

A seguir está a lista de requisitos não funcionais derivados das características do produto, contendo: a numeração do requisito; seu nome; sua descrição; e sua classificação URPS+.

| ID | Nome | Descrição | Classificação URPS+ |
| :---: | :--- | :--- | :---: |
| <span id="rnf01"></span>RNF01 | O sistema deve exibir alertas de alunos aniversariantes da semana em até 3 segundos após login | O sistema deve carregar e apresentar a lista de alunos aniversariantes da semana em até 3 segundos após o usuário realizar login no sistema. | Performance |
| <span id="rnf02"></span>RNF02 | Registro de presença deve ser feito em menos de dois segundos | Ao confirmar o registro de presença de um aluno, o sistema deve processar a operação em menos de dois segundos sem bloquear a interface do usuário. | Performance |
| <span id="rnf03"></span>RNF03 | Privacidade de Dados e Retenção Segura (LGPD) | O sistema deve garantir a privacidade dos dados pessoais restringindo sua visualização apenas a usuários autenticados e deve permitir a inativação lógica de cadastros (ocultando-os das operações diárias sem excluir o histórico), apoiando a segurança da informação exigida pela LGPD. | Segurança |
| <span id="rnf04"></span>RNF04 | Apenas usuários autenticados podem acessar o sistema | O acesso ao sistema deve ser restrito exclusivamente a usuários que realizem autenticação válida, impedindo acesso não autorizado a qualquer funcionalidade. | Segurança |
| <span id="rnf05"></span>RNF05 | Registro de auditoria (Logs) de estoque | O sistema deve manter um registro de todas as operações relacionadas ao estoque de kimonos, incluindo usuários e ações realizadas para fins de auditoria. | Suportabilidade |
| <span id="rnf06"></span>RNF06 | Interface responsiva e adaptável a múltiplos dispositivos | A interface do sistema deve preservar a usabilidade e adaptar os componentes visuais para resoluções de monitores desktop e dispositivos móveis (smartphones). | Usabilidade |
| <span id="rnf07"></span>RNF07 | Senhas armazenadas com criptografia AES256 | O sistema deve proteger senhas e credenciais contra acessos não autorizados por meio de algoritmo de criptografia forte. | Segurança |
| <span id="rnf08"></span>RNF08 | Indicadores e dashboards atualizados em até 3 segundos | Os indicadores e dashboards do sistema devem ser atualizados e refletir dados em tempo real em até 3 segundos após qualquer mudança nos dados. | Performance |
| <span id="rnf09"></span>RNF09 | Interface com suporte a Modo Escuro (Dark Mode) alternável | O sistema deve disponibilizar uma opção de "modo escuro" alternável pelo usuário, aplicando uma paleta de cores de fundo escuro e textos de alto contraste em todas as telas, preservando a legibilidade e a consistência visual. | Usabilidade |

!!! info "Requisitos não funcionais trânsversais :" 
    **RNF03**, **RNF06** e o **RNF09** se aplicam a todo o projeto

## 8.3 Matriz-síntese de rastreabilidade

A matriz a seguir representa a rastreabilidade entre objetivos específicos (OE), características do produto (CP), valores de negócio (VN), requisitos funcionais (RFs) e não funcionais (RNFs).

| Contribuição principal | Contribuição secundária | CP | VN | RFs relacionados | RNFs relacionados |
| :---: | :---: | :---: | :---: | :---: | :---: |
| OE01 | - | CP01 | VN01 | RF01, RF02, RF03, RF04, RF05 | - |
| OE01 | - | CP02 | VN02 | RF35, RF36, RF37, RF38, RF39, RF40, RF41 | RNF04, RNF07 |
| OE01 | - | CP03 | VN03 | RF28 | RNF01, RNF08 |
| OE02 | OE04 | CP04 | VN04 | RF13, RF14, RF15, RF16 | RNF02 |
| OE02 | OE04 | CP05 | VN05 | RF06, RF07, RF08, RF09, RF10, RF11, RF12, RF30, RF31, RF32, RF33, RF34 | - |
| OE03 | - | CP06 | VN06 | RF18, RF19, RF20 | - |
| OE03 | - | CP07 | VN07 | RF21, RF22 | RNF05 |
| OE04 | OE01 | CP08 | VN08 | RF23, RF24, RF25 | - |
| OE04 | OE02 | CP09 | VN09 | RF17, RF26, RF27, RF28 | - |

## 8.4 Árvore de Rastreabilidade

A árvore de rastreabilidade visual apresenta as conexões entre os objetivos estratégicos, as características do produto, os valores de negócio e os requisitos funcionais e não funcionais, permitindo acompanhar como cada funcionalidade contribui para o valor de negócio do projeto.

![Árvore de Rastreabilidade](../assets/arvoreRastreabilidade.jpg){ width="800" }
**Figura 4:** Árvore de Rastreabilidade. Fonte: Elaborada por Pedro Lucas

Disponível em: [Árvore de Rastreabilidade](https://www.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/SVAdS-FIGJAM?node-id=0-1&p=f&t=1atgk2CdgQM7cyIf-0)

<!--<iframe style="border: 2px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://embed.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/Árvore-de-Rastreabilidade?embed-host=share" allowfullscreen></iframe>-->