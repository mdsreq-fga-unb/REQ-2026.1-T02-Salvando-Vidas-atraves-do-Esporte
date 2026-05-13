# 8 Requisitos de Software

## 8.1 Lista de Requisitos Funcionais

Os requisitos funcionais descrevem as funcionalidades específicas que o sistema deve implementar para atender às necessidades da instituição Salvando Vidas Através do Esporte, realizado pela Segunda Igreja Batista do Recanto das Emas. A seguir, são apresentados o conjunto preliminar de requisitos.

**RF01 – Cadastrar alunos:** Permitir a inserção de um novo aluno no sistema, registrando seus dados pessoais e de matrícula para vinculação às atividades.

**RF02 – Editar dados do aluno:** Permitir a alteração das informações cadastrais de um aluno já registrado no sistema.

**RF03 – Inativar cadastro de aluno:** Permitir a alteração do status de um aluno para inativo, mantendo seu histórico, mas removendo-o das listas ativas.

**RF04 – Buscar dados do aluno:** Permitir a pesquisa dos dados de alunos cadastrados utilizando parâmetros como nome ou matrícula para localizar seus registros.

**RF05 – Cadastrar responsável legal:** Permitir a inserção dos dados de um responsável legal no sistema para posterior vinculação aos alunos.

**RF06 – Vincular responsável ao aluno:** Permitir a criação de uma relação no sistema entre o cadastro de um aluno e o de seu responsável legal.

**RF07 – Editar dados do responsável:** Permitir a modificação das informações pessoais e de contato de um responsável legal previamente cadastrado.

**RF08 - Inativar responsável:**

**RF09 - Cadastrar turma:**

**RF10 - Editar turma:**

**RF11 - Inativar turma:**

**RF12 - Buscar turmas:**

**RF13 – Registrar presença em aula:** Permitir a marcação de presença ou falta para os alunos associados a uma aula ou turma selecionada.

**RF14 – Registrar detalhes da aula:** Permitir a descrição das atividades realizadas e temas abordados em uma aula registrada no sistema.

**RF15 – Editar registro de presença:** Permitir a retificação do status de frequência de um aluno em uma aula após o lançamento inicial.

**RF16 – Consultar histórico de presença:** Permitir a visualização consolidada dos registros de frequência de um aluno ao longo de um período selecionado.

**RF17 – Listar alunos em risco de evasão:** Permitir a geração de uma relação dos alunos que atingiram os parâmetros de alerta para risco de evasão.

**RF18 – Cadastrar doação de kimonos:** Permitir a adição de novas unidades de kimonos ao controle de estoque, atualizando a quantidade disponível.

**RF19 – Inativar materiais danificados:** Permitir o registro da remoção de itens do estoque devido a danos ou perda, atualizando o inventário.

**RF20 – Consultar estoque disponível:** Permitir a verificação da quantidade atualizada de um determinado material ou equipamento no inventário.

**RF21 – Vincular empréstimo do kimono:** Permitir a vinculação da saída de um material do estoque a um aluno por um período determinado.

**RF22 – Desvincular devolução do kimono:** Permitir o registro do retorno de um material emprestado, reintegrando-o à contagem do estoque.

**RF23 – Registrar observações pedagógicas:** Permitir a inserção de apontamentos sobre o comportamento e desenvolvimento educacional do aluno.

**RF24 – Registrar orientações aos responsáveis:** Permitir a documentação das comunicações, diretrizes e feedbacks repassados aos responsáveis do aluno.

**RF25 – Visualizar orientações e observações:** Permitir a exibição cronológica de todas as observações e registros pedagógicos associados a um aluno.

**RF26 – Gerar relatório social:** Permitir a compilação e exportação dos dados sociais e informações de vulnerabilidade do aluno.

**RF27 – Listar alunos aniversariantes:** Permitir a filtragem e exibição dos alunos que completam ano de vida em um mês ou período determinado.

**RF28 – Exibir histórico de faixas:** Permitir a visualização do registro cronológico de todas as graduações e exames já realizados pelo aluno.

**RF29 – Cadastrar campeonato:** Permitir a documentação dos eventos competitivos dos quais o aluno participou, registrando as datas.

**RF30 - Editar campeonato:**

**RF31 - Inativar campeonato:**

**RF32 - Vincular aluno num campeonato:**

**RF33 - Desvincular aluno de um campeonato:**

**RF34 – Cadastrar usuário voluntário:** Permitir a inserção no sistema dos perfis de professores, monitores e demais colaboradores do projeto.

**RF35 - Inativar usuário voluntário:**

**RF36 - Editar dados do usuário voluntário:**

**RF37 - Buscar usuários voluntários:**


## 8.2 Lista de Requisitos Não Funcionais

A seguir está a lista de requisitos não funcionais derivados das características do produto, a lista contêm: a numeração do requisito; seu nome; sua classificação conforme o modelo URPS+ e sua descrição.

**RNF01 - Dashboard deve apresentar as informações essenciais em dois cliques ou menos - Usabilidade:** A visualização das informações presentes no dashboard, como informações sobre a turma e alertas de aniversários, e o registro de presenças devem ser facilmente localizados pelos voluntários sem a necessidade de um fluxo complexo de navegação. 

**RNF02 - Banco de dados deve ser capaz de armazenar os registros de entrada, saída de kimonos por um ano - Confiabilidade:** O banco de dados deve ter o armazenamento necessário para registrar as entradas, saídas e o estoque total de kimonos por um ano, com backups que podem ser usados para recuperação dos registros em caso de falha.

**RNF03 - Alerta deve ser exibido quando um aluno tiver 2 semanas de faltas consecutivas - Confiabilidade:** O sistema deve mostrar no dashboard um alerta e enviar uma notificação sobre a ocorrência de alunos que estão faltando por um período determinado pela equipe do projeto social.

**RNF04 - Dashboard deve exibir alertas sobre os alunos aniversariantes da semana - Confiabilidade:** O sistema deve mostrar no dashboard uma lista de alunos que farão aniversários durante a semana, permitindo o planejamento de celebrações mesmo que o aniversário aconteça fora de um dia de aula.

**RNF05 - Registro de presença deve ser feito em menos de um segundo - Desempenho:** Ao clicar no botão para registrar a presença de um aluno o sistema deve executar o registro em tempo real sem bloquear a interface por um longo período.

## 8.3 Matriz-síntese de rastreabilidade

A matriz, a seguir, representa a rastreabilidade entre objetivos específicos (OE), características de produto (CP), valor de negócio (VN), requisitos funcionais (RFs) e não funcionais (RNFs).

| Contribuição principal | Contribuição secundária | CP | VN | RFs relacionados | RNFs relacionados |
| :---: | :---: | :---: | :---: | :---: | :---: |
| OE01 | - | CP01 | VN01 | RF01, RF02, RF03, RF04, RF34, RF35, RF36, RF37, RF38 | RNF01, RNF03, RNF04, RNF05, RNF06 |
| OE01 | - | CP02 | VN02 | RF05, RF06, RF07, RF08 | RNF01, RNF03, RNF05 | 
| OE01 | - | CP03 | VN03 | RF43, RF44, RF45 | RNF01, RNF02, RNF04, RNF06 |
| OE02 | OE04 | CP04 | VN04 | RF09, RF10, RF11, RF12, RF13 | RNF01, RNF02, RNF04, RNF06 |
| OE02 | OE04 | CP05 | VN05 | RF14, RF15, RF16 | RNF03, RNF04, RNF05 |
| OE03 | - | CP06 | VN06 | RF17, RF18, RF19, RF20 | RNF01, RNF02, RNF06 |
| OE03 | - | CP07 | VN07 | RF21, RF22, RF23, RF24 | RNF01, RNF02, RNF03, RNF05 |
| OE04 | OE01 | CP08 | VN08 | RF25, RF26, RF27, RF28, RF29, RF39, RF40, RF41, RF42 | RNF01, RNF03, RNF05 |
| OE04 | OE02 | CP09 | VN09 | RF30, RF31, RF32, RF33 | RNF03, RNF04, RNF05 |
