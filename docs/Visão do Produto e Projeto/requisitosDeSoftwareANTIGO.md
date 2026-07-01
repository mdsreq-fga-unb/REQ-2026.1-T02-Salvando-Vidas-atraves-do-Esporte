# 8 Requisitos de Software

## 8.1 Lista de Requisitos Funcionais

Os requisitos funcionais descrevem as funcionalidades específicas que o sistema deve implementar para atender às necessidades da instituição Salvando Vidas Através do Esporte, realizado pela Segunda Igreja Batista do Recanto das Emas. A seguir, são apresentados o conjunto preliminar de requisitos.

| ID | Nome | Descrição |
| :---: | :--- | :--- |
| RF01 | Cadastrar aluno e responsáveis | Permitir a inserção de um novo aluno no sistema, registrando seus dados pessoais e de matrícula, vinculando-o a seus responsáveis legais ou cadastrando-os simultaneamente se necessário. |
| RF02 | Editar dados cadastrais | Permitir a alteração das informações cadastrais de um aluno ou responsável já registrado no sistema. |
| RF03 | Inativar cadastro | Permitir a alteração do status de um aluno ou responsável para inativo, mantendo seu histórico, mas removendo-o das listas ativas. |
| RF04 | Buscar dados cadastrais | Permitir a pesquisa dos dados de alunos e responsáveis cadastrados utilizando parâmetros como nome ou matrícula para localizar seus registros. |
| RF05 | Vincular responsável ao aluno | Permitir a criação de uma relação no sistema entre o cadastro de um aluno e o de seu responsável legal. |
| RF06 | Desvincular responsável ao aluno | Permitir a remoção da relação entre um aluno e seu responsável legal, desfazendo a vinculação prévia. |
| RF07 | Cadastrar turma | Permitir a criação de uma nova turma no sistema, registrando detalhes como faixa etária, dias da semana, horários de aula e o professor voluntário responsável. |
| RF08 | Editar turma | Permitir a alteração das informações e configurações de uma turma previamente cadastrada no sistema. |
| RF09 | Inativar turma | Permitir a alteração do status de uma turma para inativa, encerrando suas atividades regulares, mas mantendo intacto o histórico de aulas e alunos vinculados. |
| RF10 | Buscar turmas | Permitir a pesquisa e filtragem das turmas cadastradas utilizando parâmetros como dias de aula, horários ou professor para localizar seus registros. |
| RF11 | Vincular aluno à turma | Permitir a associação de um aluno a uma turma específica, formalizando sua inscrição e participação nas atividades daquela turma. |
| RF12 | Desvincular aluno da turma | Permitir a remoção do vínculo de um aluno com uma turma, cancelando sua inscrição ou participação naquela turma. |
| RF13 | Registrar presença em aula | Permitir a marcação de presença ou falta para os alunos associados a uma aula ou turma selecionada. |
| RF14 | Registrar o conteúdo e as ocorrências gerais da aula | Permitir a descrição das atividades realizadas, temas abordados e eventos relevantes que ocorreram em uma aula registrada no sistema. |
| RF15 | Editar registro de presença | Permitir a retificação do status de frequência de um aluno em uma aula após o lançamento inicial. |
| RF16 | Consultar histórico de presença | Permitir a visualização consolidada dos registros de frequência de um aluno ao longo de um período selecionado. |
| RF17 | Listar alunos em risco de evasão | Permitir a geração de uma relação dos alunos que atingiram os parâmetros de alerta para risco de evasão. |
| RF18 | Cadastrar doação de kimonos | Permitir a adição de novas unidades de kimonos ao controle de estoque, atualizando a quantidade disponível. |
| RF19 | Inativar kimonos danificados | Permitir o registro da remoção de itens do estoque devido a danos ou perda, atualizando o inventário. |
| RF20 | Consultar estoque disponível | Permitir a verificação da quantidade atualizada de um determinado material ou equipamento no inventário. |
| RF21 | Registrar empréstimo de kimono | Permitir o registro da saída de um kimono do estoque, vinculando-o a um aluno específico com um período determinado de empréstimo. |
| RF22 | Registrar devolução de kimono | Permitir o registro do retorno e desvinculação de um kimono emprestado, reintegrando-o ao estoque disponível no inventário. |
| RF23 | Registrar e vincular observações pedagógicas ao aluno | Permitir a inserção de apontamentos sobre o comportamento e desenvolvimento educacional do aluno. |
| RF24 | Registrar orientações aos responsáveis | Permitir a documentação das comunicações, diretrizes e feedbacks repassados aos responsáveis do aluno. |
| RF25 | Editar registros pedagógicos | Permitir a alteração e atualização de observações e registros pedagógicos previamente cadastrados para um aluno. |
| RF26 | Visualizar orientações e observações pedagógicas | Permitir a exibição cronológica de todas as observações, orientações e registros pedagógicos associados a um aluno. |
| RF27 | Gerar relatório social | Permitir a geração, compilação e exportação de um relatório consolidado contendo dados sociais e informações de vulnerabilidade do aluno. |
| RF28 | Exibir histórico de faixas | Permitir a visualização do registro cronológico de todas as graduações e exames já realizados pelo aluno. |
| RF29 | Listar alunos aniversariantes | Permitir a filtragem e exibição dos alunos que completam ano de vida em um mês ou período determinado. |
| RF30 | Cadastrar campeonato | Permitir o registro e documentação de um novo campeonato ou evento competitivo no qual os alunos da instituição podem participar, incluindo datas e detalhes do evento. |
| RF31 | Editar campeonato | Permitir a alteração dos dados de um evento competitivo previamente cadastrado, como modificação de nome, data ou local de realização. |
| RF32 | Inativar campeonato | Permitir a alteração do status de um campeonato para inativo (cancelado ou finalizado), preservando os registros de participação passados. |
| RF33 | Vincular aluno de um campeonato | Permitir a inscrição e associação de um aluno cadastrado a um campeonato específico, formalizando sua participação e registro no evento. |
| RF34 | Desvincular aluno de um campeonato | Permitir a remoção do vínculo de um aluno com um campeonato, cancelando a sua inscrição ou retirando seu registro de participação. |
| RF35 | Cadastrar usuário voluntário | Permitir a inserção no sistema dos perfis de professores, monitores e demais colaboradores do projeto. |
| RF36 | Editar dados do usuário voluntário | Permitir a alteração das informações pessoais, de contato ou de perfil de um usuário voluntário já registrado no sistema. |
| RF37 | Inativar usuário voluntário | Permitir a alteração do status de um usuário voluntário para inativo, revogando seu acesso ao sistema e suas atribuições ativas, mas preservando o histórico de sua atuação no projeto. |
| RF38 | Buscar usuários voluntários | Permitir a pesquisa dos dados de usuários voluntários utilizando parâmetros como nome ou função para localizar seus perfis e cadastros. |
| RF39 | Encerrar sessão de usuário | Permitir que um usuário faça logout do sistema, encerrando sua sessão de forma segura. |
| RF40 | Gerenciar níveis de acesso dos usuários | Permitir a configuração e atualização dos permissões e níveis de acesso de cada usuário no sistema. |
| RF41 | Realizar login (autenticação) | Permitir que usuários cadastrados acessem o sistema mediante validação de credenciais, garantindo que apenas usuários autorizados obtenham acesso às funcionalidades disponíveis conforme seu perfil. |
| RF42 | Reativar cadastro de aluno e responsável | Permitir a reativação do status de um aluno ou responsável previamente inativado, restaurando-o às listas ativas do sistema e reestabelecendo seu vínculo com as informações registradas. |
| RF43 | Reativar usuário voluntário | Permitir a reativação do status de um usuário voluntário previamente inativado, restabelecendo seu acesso ao sistema e suas atribuições, mantendo o histórico de atuação anterior. |
| RF44 | Reativar turma | Permitir a reativação do status de uma turma previamente inativada, retomando suas atividades regulares no sistema e mantendo o histórico de aulas e alunos vinculados. |


## 8.2 Lista de Requisitos Não Funcionais

A seguir está a lista de requisitos não funcionais derivados das características do produto, contendo: a numeração do requisito; seu nome; sua descrição; e sua classificação URPS+.

| ID | Nome | Descrição | Classificação URPS+ |
| :---: | :--- | :--- | :---: |
| RNF01 | Dashboard deve apresentar as informações essenciais em até três cliques | O dashboard deve exibir as informações principais como dados da turma, alertas de aniversários e registro de presenças de forma simplificada e acessível aos voluntários. | Usabilidade |
| RNF02 | O sistema deve exibir alertas de alunos aniversariantes da semana em até 3 segundos após login | O sistema deve carregar e apresentar a lista de alunos aniversariantes da semana em até 3 segundos após o usuário realizar login no sistema. | Performance |
| RNF03 | Registro de presença deve ser feito em menos de um segundo | Ao confirmar o registro de presença de um aluno, o sistema deve processar a operação em menos de um segundo sem bloquear a interface do usuário. | Performance |
| RNF04 | Privacidade de Dados e Retenção Segura (LGPD) | O sistema deve garantir a privacidade dos dados pessoais restringindo sua visualização apenas a usuários autenticados e deve permitir a inativação lógica de cadastros (ocultando-os das operações diárias sem excluir o histórico), apoiando a segurança da informação exigida pela LGPD. | Segurança |
| RNF05 | Apenas usuários autenticados podem acessar o sistema | O acesso ao sistema deve ser restrito exclusivamente a usuários que realizem autenticação válida, impedindo acesso não autorizado a qualquer funcionalidade. | Segurança |
| RNF06 | Registro de auditoria (Logs) de estoque | O sistema deve manter um registro de todas as operações relacionadas ao estoque de kimonos, incluindo datas, usuários e ações realizadas para fins de auditoria. | Suportabilidade |
| RNF07 | Interface responsiva e adaptável a múltiplos dispositivos | A interface do sistema deve preservar a usabilidade e adaptar os componentes visuais para resoluções de monitores desktop e dispositivos móveis (smartphones). | Usabilidade |
| RNF08 | Senhas armazenadas com criptografia | O sistema deve proteger senhas e credenciais contra acessos não autorizados por meio de algoritmo de criptografia forte. | Segurança |
| RNF09 | Indicadores atualizados em menos de 3 segundos | Os indicadores e dashboards do sistema devem ser atualizados e refletir dados em tempo real em menos de 3 segundos após qualquer mudança nos dados. | Performance |
| RNF10 |Interface com suporte a Modo Escuro (Dark Mode) alternável | O sistema deve disponibilizar uma opção de "modo escuro" alternável pelo usuário, aplicando uma paleta de cores de fundo escuro e textos de alto contraste em todas as telas, preservando a legibilidade e a consistência visual. | Usabilidade |

!!! info "Requisitos não funcionais trânsversais :" 
    **RNF04**, **RNF07** e o **RNF10** se aplicam a todo o projeto

## 8.3 Matriz-síntese de rastreabilidade

A matriz a seguir representa a rastreabilidade entre objetivos específicos (OE), características do produto (CP), valores de negócio (VN), requisitos funcionais (RFs) e não funcionais (RNFs).

| Contribuição principal | Contribuição secundária | CP | VN | RFs relacionados | RNFs relacionados |
| :---: | :---: | :---: | :---: | :---: | :---: |
| OE01 | - | CP01 | VN01 | RF01, RF02, RF03, RF04, RF05, RF06, RF42 | - |
| OE01 | - | CP02 | VN02 | RF35, RF36, RF37, RF38, RF39, RF40, RF41, RF43 | RNF05, RNF08 | 
| OE01 | - | CP03 | VN03 | RF28 | RNF01, RNF02, RNF09 |
| OE02 | OE04 | CP04 | VN04 | RF13, RF14, RF15, RF16 | RNF03 |
| OE02 | OE04 | CP05 | VN05 | RF07, RF08, RF09, RF10, RF11, RF12, RF30, RF31, RF32, RF33, RF34, RF44 | - |
| OE03 | - | CP06 | VN06 | RF18, RF19, RF20 | - |
| OE03 | - | CP07 | VN07 | RF21, RF22 | RNF06 |
| OE04 | OE01 | CP08 | VN08 | RF23, RF24, RF25 | - |
| OE04 | OE02 | CP09 | VN09 | RF17, RF26, RF27, RF28 | - |

## 8.1 Árvore de Rastreabilidade

A árvore de rastreabilidade visual apresenta as conexões entre os objetivos estratégicos, as características do produto, os valores de negócio e os requisitos funcionais e não funcionais, permitindo acompanhar como cada funcionalidade contribui para o valor de negócio do projeto.

![Árvore de Rastreabilidade](../assets/arvoreRastreabilidade.jpg){ width="800" }
**Figura 4:** Árvore de Rastreabilidade. Fonte: Elaborada por Pedro Lucas

Disponível em: [Árvore de Rastreabilidade](https://www.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/SVAdS-FIGJAM?node-id=0-1&p=f&t=1atgk2CdgQM7cyIf-0)

<!--<iframe style="border: 2px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://embed.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/Árvore-de-Rastreabilidade?embed-host=share" allowfullscreen></iframe>-->