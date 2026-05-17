# 8 Requisitos de Software

## 8.1 Lista de Requisitos Funcionais

Os requisitos funcionais descrevem as funcionalidades específicas que o sistema deve implementar para atender às necessidades da instituição Salvando Vidas Através do Esporte, realizado pela Segunda Igreja Batista do Recanto das Emas. A seguir, são apresentados o conjunto preliminar de requisitos.

| ID | Nome | Descrição | Classificação MoSCoW |
| :---: | :--- | :--- | :--- |
| RF01 | Cadastrar aluno e responsáveis | Permitir a inserção de um novo aluno no sistema, registrando seus dados pessoais e de matrícula, vinculando-o a seus responsáveis legais ou cadastrando-os simultaneamente se necessário. | MUST |
| RF02 | Editar dados cadastrais | Permitir a alteração das informações cadastrais de um aluno ou responsável já registrado no sistema. | MUST |
| RF03 | Inativar cadastro | Permitir a alteração do status de um aluno ou responsável para inativo, mantendo seu histórico, mas removendo-o das listas ativas. | SHOULD |
| RF04 | Buscar dados cadastrais | Permitir a pesquisa dos dados de alunos e responsáveis cadastrados utilizando parâmetros como nome ou matrícula para localizar seus registros. | MUST |
| RF05 | Vincular responsável ao aluno | Permitir a criação de uma relação no sistema entre o cadastro de um aluno e o de seu responsável legal. | MUST |
| RF06 | Desvincular responsável ao aluno | Permitir a remoção da relação entre um aluno e seu responsável legal, desfazendo a vinculação prévia. | MUST |
| RF07 | Cadastrar turma | Permitir a criação de uma nova turma no sistema, registrando detalhes como faixa etária, dias da semana, horários de aula e o professor voluntário responsável. | MUST |
| RF08 | Editar turma | Permitir a alteração das informações e configurações de uma turma previamente cadastrada no sistema. | MUST |
| RF09 | Inativar turma | Permitir a alteração do status de uma turma para inativa, encerrando suas atividades regulares, mas mantendo intacto o histórico de aulas e alunos vinculados. | SHOULD |
| RF10 | Buscar turmas | Permitir a pesquisa e filtragem das turmas cadastradas utilizando parâmetros como dias de aula, horários ou professor para localizar seus registros. | COULD |
| RF11 | Vincular aluno à turma | Permitir a associação de um aluno a uma turma específica, formalizando sua inscrição e participação nas atividades daquela turma. | SHOULD |
| RF12 | Desvincular aluno da turma | Permitir a remoção do vínculo de um aluno com uma turma, cancelando sua inscrição ou participação naquela turma. | SHOULD |
| RF13 | Registrar presença em aula | Permitir a marcação de presença ou falta para os alunos associados a uma aula ou turma selecionada. | MUST |
| RF14 | Registrar ocorrências da aula | Permitir a descrição das atividades realizadas, temas abordados e eventos relevantes que ocorreram em uma aula registrada no sistema. | COULD |
| RF15 | Editar registro de presença | Permitir a retificação do status de frequência de um aluno em uma aula após o lançamento inicial. | SHOULD |
| RF16 | Consultar histórico de presença | Permitir a visualização consolidada dos registros de frequência de um aluno ao longo de um período selecionado. | SHOULD |
| RF17 | Listar alunos em risco de evasão | Permitir a geração de uma relação dos alunos que atingiram os parâmetros de alerta para risco de evasão. | MUST |
| RF18 | Cadastrar doação de kimonos | Permitir a adição de novas unidades de kimonos ao controle de estoque, atualizando a quantidade disponível. | MUST |
| RF19 | Inativar kimonos danificados | Permitir o registro da remoção de itens do estoque devido a danos ou perda, atualizando o inventário. | SHOULD |
| RF20 | Consultar estoque disponível | Permitir a verificação da quantidade atualizada de um determinado material ou equipamento no inventário. | MUST |
| RF21 | Vincular empréstimo do kimono | Permitir o registro da saída de um kimono do estoque, vinculando-o a um aluno específico com um período determinado de empréstimo. | MUST |
| RF22 | Desvincular devolução do kimono | Permitir o registro do retorno e desvinculação de um kimono emprestado, reintegrando-o ao estoque disponível no inventário. | MUST |
| RF23 | Registrar observações pedagógicas | Permitir a inserção de apontamentos sobre o comportamento e desenvolvimento educacional do aluno. | SHOULD |
| RF24 | Registrar orientações aos responsáveis | Permitir a documentação das comunicações, diretrizes e feedbacks repassados aos responsáveis do aluno. | COULD |
| RF25 | Editar registros pedagógicos | Permitir a alteração e atualização de observações e registros pedagógicos previamente cadastrados para um aluno. | COULD |
| RF26 | Vincular registros pedagógicos ao aluno | Permitir a vinculação e associação de observações, acompanhamentos e documentos pedagógicos ao perfil de um aluno específico no sistema. | COULD |
| RF27 | Visualizar orientações e observações pedagógicas | Permitir a exibição cronológica de todas as observações, orientações e registros pedagógicos associados a um aluno. | COULD |
| RF28 | Gerar relatório social | Permitir a geração, compilação e exportação de um relatório consolidado contendo dados sociais e informações de vulnerabilidade do aluno. | WONT |
| RF29 | Exibir histórico de faixas | Permitir a visualização do registro cronológico de todas as graduações e exames já realizados pelo aluno. | COULD |
| RF30 | Listar alunos aniversariantes | Permitir a filtragem e exibição dos alunos que completam ano de vida em um mês ou período determinado. | MUST |
| RF31 | Cadastrar campeonato | Permitir o registro e documentação de um novo campeonato ou evento competitivo no qual os alunos da instituição podem participar, incluindo datas e detalhes do evento. | COULD |
| RF32 | Editar campeonato | Permitir a alteração dos dados de um evento competitivo previamente cadastrado, como modificação de nome, data ou local de realização. | COULD |
| RF33 | Inativar campeonato | Permitir a alteração do status de um campeonato para inativo (cancelado ou finalizado), preservando os registros de participação passados. | COULD |
| RF34 | Vincular aluno de um campeonato | Permitir a inscrição e associação de um aluno cadastrado a um campeonato específico, formalizando sua participação e registro no evento. | COULD |
| RF35 | Desvincular aluno de um campeonato | Permitir a remoção do vínculo de um aluno com um campeonato, cancelando a sua inscrição ou retirando seu registro de participação. | COULD |
| RF36 | Cadastrar usuário voluntário | Permitir a inserção no sistema dos perfis de professores, monitores e demais colaboradores do projeto. | SHOULD |
| RF37 | Editar dados do usuário voluntário | Permitir a alteração das informações pessoais, de contato ou de perfil de um usuário voluntário já registrado no sistema. | SHOULD |
| RF38 | Inativar usuário voluntário | Permitir a alteração do status de um usuário voluntário para inativo, revogando seu acesso ao sistema e suas atribuições ativas, mas preservando o histórico de sua atuação no projeto. | SHOULD |
| RF39 | Buscar usuários voluntários | Permitir a pesquisa dos dados de usuários voluntários utilizando parâmetros como nome ou função para localizar seus perfis e cadastros. | COULD |
| RF40 | Encerrar sessão de usuário | Permitir que um usuário faça logout do sistema, encerrando sua sessão de forma segura. | COULD |
| RF41 | Gerenciar níveis de acesso dos usuários | Permitir a configuração e atualização dos permissões e níveis de acesso de cada usuário no sistema. | SHOULD |


## 8.2 Lista de Requisitos Não Funcionais

A seguir está a lista de requisitos não funcionais derivados das características do produto, contendo: a numeração do requisito; seu nome; sua descrição; e sua classificação URPS+.

| ID | Nome | Descrição | Classificação URPS+ |
| :---: | :--- | :--- | :---: |
| RNF01 | Dashboard deve apresentar as informações essenciais em até três cliques | O dashboard deve exibir as informações principais como dados da turma, alertas de aniversários e registro de presenças de forma simplificada e acessível aos voluntários. | Usabilidade |
| RNF02 | O sistema deve exibir alerta de risco de evasão quando um aluno tiver 2 semanas de faltas consecutivas | O sistema exibirá um alerta no dashboard quando detectar que um aluno completou duas semanas de faltas consecutivas, permitindo ação preventiva pela equipe. | Confiabilidade |
| RNF03 | O sistema deve exibir alertas de alunos aniversariantes da semana em até 3 segundos após login | O sistema deve carregar e apresentar a lista de alunos aniversariantes da semana em até 3 segundos após o usuário realizar login no sistema. | Performance |
| RNF04 | Registro de presença deve ser feito em menos de um segundo | Ao confirmar o registro de presença de um aluno, o sistema deve processar a operação em menos de um segundo sem bloquear a interface do usuário. | Performance |
| RNF05 | Proteção de dados sensíveis e conformidade com a LGPD | O sistema deve implementar mecanismos de proteção de dados pessoais dos alunos e responsáveis, garantindo conformidade total com a Lei Geral de Proteção de Dados Pessoais. | Segurança |
| RNF06 | Apenas usuários autenticados podem acessar o sistema | O acesso ao sistema deve ser restrito exclusivamente a usuários que realizem autenticação válida, impedindo acesso não autorizado a qualquer funcionalidade. | Segurança |
| RNF07 | Registro de auditoria (Logs) de estoque | O sistema deve manter um registro detalhado de todas as operações relacionadas ao estoque de kimonos, incluindo datas, usuários e ações realizadas para fins de auditoria. | Suportabilidade |
| RNF08 | Interface responsiva e adaptável a múltiplos dispositivos | A interface do sistema deve ser responsiva e funcionar adequadamente em diferentes tamanhos de tela e dispositivos, como desktops, tablets e smartphones. | Usabilidade |
| RNF09 | Senhas armazenadas com criptografia AES256 | Todas as senhas de usuários devem ser armazenadas utilizando o algoritmo de criptografia AES256, garantindo a segurança das credenciais. | Segurança |
| RNF10 | Indicadores atualizados em menos de 3 segundos | Os indicadores e dashboards do sistema devem ser atualizados e refletir dados em tempo real em menos de 3 segundos após qualquer mudança nos dados. | Performance |

!!! info "Requisitos não funcionais trânsversais :" 
    **RNF05** e o **RNF06** se aplicam a todo o projeto

## 8.3 Matriz-síntese de rastreabilidade

A matriz a seguir representa a rastreabilidade entre objetivos específicos (OE), características do produto (CP), valores de negócio (VN), requisitos funcionais (RFs) e não funcionais (RNFs).

| Contribuição principal | Contribuição secundária | CP | VN | RFs relacionados | RNFs relacionados |
| :---: | :---: | :---: | :---: | :---: | :---: |
| OE01 | - | CP01 | VN01 | RF01, RF02, RF03, RF04, RF05, RF06 | - |
| OE01 | - | CP02 | VN02 | RF36, RF37, RF38, RF39, RF40, RF41 | RNF06, RNF09 | 
| OE01 | - | CP03 | VN03 | RF30 | RNF01, RNF02, RNF03, RNF10 |
| OE02 | OE04 | CP04 | VN04 | RF13, RF14, RF15, RF16 | RNF04 |
| OE02 | OE04 | CP05 | VN05 | RF07, RF08, RF09, RF10, RF11, RF12, RF31, RF32, RF33, RF34, RF35 | - |
| OE03 | - | CP06 | VN06 | RF18, RF19, RF20 | - |
| OE03 | - | CP07 | VN07 | RF21, RF22 | RNF07 |
| OE04 | OE01 | CP08 | VN08 | RF23, RF24, RF25, RF26 | - |
| OE04 | OE02 | CP09 | VN09 | RF17, RF27, RF28, RF29 | - |

## 8.4 Árvore de Rastreabilidade

<iframe style="border: 2px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://embed.figma.com/board/Pl8q1fRIxDhYP1zkDhp3N7/Árvore-de-Rastreabilidade?embed-host=share" allowfullscreen></iframe>
