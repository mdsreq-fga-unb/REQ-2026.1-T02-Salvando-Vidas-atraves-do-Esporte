# Backlog

O backlog do produto é uma lista ordenada e dinâmica de todas as funcionalidades, melhorias e correções necessárias para o desenvolvimento da solução. Ele serve como a principal fonte de requisitos para a equipe, sendo constantemente refinado à medida que o entendimento sobre o projeto evolui e novos feedbacks do cliente são coletados. No contexto do processo RAD, o backlog é essencial para garantir que as iterações foquem no que gera maior valor de negócio e impacto social imediato.

## 10.1 Backlog Geral

A presente seção detalha o Backlog Geral do produto, organizado a partir da visão orientada a valor em Temas, Épicos e Histórias de Usuário. 

> **Nota sobre a Elicitação das Histórias de Usuário:** Em alinhamento com as práticas do método RAD, as Histórias de Usuário apresentadas neste backlog não constituem transcrições literais das falas do cliente. Elas foram formuladas, interpretadas e estruturadas pela equipe técnica com base nas dores e necessidades mapeadas durante os workshops e entrevistas. Elas representam a compreensão da equipe sobre o escopo e servem como "promessas de conversação", sendo continuamente validadas e refinadas com os stakeholders ao longo dos ciclos de prototipagem.

### Visão Estrutural do Backlog

Antes do detalhamento granular, apresenta-se a síntese arquitetural do escopo do produto. A estrutura macro está dividida em Temas centrais de negócio, que se desdobram em Épicos e totalizam as Histórias de Usuário (US) mapeadas nesta versão preliminar:

| Tema | Épicos Abrangidos | Quantidade de Histórias (US) |
| :--- | :--- | :---: |
| Gestão de Alunos e Responsáveis | • Cadastro e Manutenção de Dados Cadastrais<br>• Vínculos entre Aluno e Responsável | 4 |
| Gestão de Turmas | • Criação e Manutenção de Turmas<br>• Matrículas e Participação em Turmas | 5 |
| Controle de Frequência e Evasão | • Registro de Presença em Aula<br>• Monitoramento e Prevenção à Evasão | 5 |
| Estoque Solidário de Kimonos | • Controle de Inventário<br>• Empréstimos e Devoluções | 4 |
| Acompanhamento Pedagógico e Engajamento | • Engajamento com a Comunidade<br>• Registros e Observações Pedagógicas<br>• Evolução e Impacto Social | 7 |
| Gestão de Campeonatos | • Configuração de Eventos Competitivos<br>• Participação dos Alunos em Competições | 4 |
| Gestão de Usuários e Acessos | • Cadastro e Manutenção de Voluntários<br>• Controle de Acesso e Segurança | 5 |
| **Total** | **15 Épicos** | **34** |

---

### Detalhamento das Histórias de Usuário

| ID da US | Tema | Épico | História de Usuário | RFs Relacionados | RNFs Relacionados |
| :---: | :--- | :--- | :--- | :---: | :---: |
| US-01 | Gestão de Alunos e Responsáveis | Cadastro e Manutenção de Dados Cadastrais | Como **Coordenador**, quero ter um lugar onde eu possa registrar os dados de cada novo aluno e dos seus responsáveis e encontrá-los facilmente quando precisar, para nunca mais depender de fichas de papel espalhadas pela sala de matrícula. | RF01, RF04 | - |
| US-02 | Gestão de Alunos e Responsáveis | Cadastro e Manutenção de Dados Cadastrais | Como **Coordenador**, quero poder corrigir as informações de um aluno ou responsável a qualquer momento e, quando alguém sair do projeto, marcar esse cadastro como inativo, para manter tudo organizado sem apagar a memória de quem já passou pelo projeto. | RF02, RF03 | - |
| US-03 | Gestão de Alunos e Responsáveis | Vínculos entre Aluno e Responsável | Como **Coordenador**, quero registrar formalmente qual responsável acompanha cada aluno, para saber com quem entrar em contato caso precise conversar sobre aquela criança. | RF05 | - |
| US-04 | Gestão de Alunos e Responsáveis | Vínculos entre Aluno e Responsável | Como **Coordenador**, quero remover o vínculo entre um aluno e seu responsável quando essa relação mudar, para garantir que as informações de tutela reflitam sempre a realidade da família. | RF06 | - |
| US-05 | Gestão de Turmas | Criação e Manutenção de Turmas | Como **Coordenador**, quero criar novas turmas informando os dias, horários, faixa etária dos alunos e o professor responsável, e poder ajustar essas configurações sempre que necessário, para ter a grade do projeto organizada e fácil de manter. | RF07, RF08 | - |
| US-06 | Gestão de Turmas | Criação e Manutenção de Turmas | Como **Coordenador**, quero encerrar uma turma que não está mais em atividade, sem perder o histórico de quem participou e das aulas que aconteceram, para preservar a memória do que o projeto já realizou mesmo depois de uma turma ser descontinuada. | RF09 | - |
| US-07 | Gestão de Turmas | Criação e Manutenção de Turmas | Como **Voluntário**, quero filtrar as turmas por dias da semana, horários ou professor, para encontrar rapidamente a turma que procuro sem precisar percorrer uma lista interminável. | RF10 | - |
| US-08 | Gestão de Turmas | Matrículas e Participação em Turmas | Como **Coordenador**, quero associar um aluno a uma turma específica, para formalizar sua participação e garantir que ele apareça nas listas de chamada certas desde o primeiro treino. | RF11 | - |
| US-09 | Gestão de Turmas | Matrículas e Participação em Turmas | Como **Coordenador**, quero cancelar a inscrição de um aluno em uma turma quando ele precisar sair, para que as listas de chamada reflitam apenas quem está efetivamente frequentando. | RF12 | - |
| US-10 | Controle de Frequência e Evasão | Registro de Presença em Aula | Como **Voluntário**, quero marcar a presença de cada aluno durante a aula de forma ágil, para fechar a chamada ainda na quadra sem precisar lembrar de tudo depois. | RF13 | RNF04 |
| US-11 | Controle de Frequência e Evasão | Registro de Presença em Aula | Como **Voluntário**, quero corrigir um registro de presença que foi lançado errado, para que o histórico de frequência de cada aluno seja confiável e justo. | RF15 | - |
| US-12 | Controle de Frequência e Evasão | Registro de Presença em Aula | Como **Voluntário**, quero anotar o que foi trabalhado em cada aula — exercícios, temas e situações relevantes —, para ter um diário pedagógico que ajude a acompanhar a evolução da turma ao longo do tempo. | RF14 | - |
| US-13 | Controle de Frequência e Evasão | Monitoramento e Prevenção à Evasão | Como **Coordenador**, quero consultar o histórico de frequência de qualquer aluno em um período específico, para entender seu padrão de presença e perceber se algo está mudando antes que vire abandono. | RF16 | - |
| US-14 | Controle de Frequência e Evasão | Monitoramento e Prevenção à Evasão | Como **Coordenador**, quero receber uma lista dos alunos que já acumularam duas semanas seguidas de faltas, com os indicadores atualizados em tempo real, para agir rápido e entrar em contato com a família antes que a criança abandone o projeto de vez. | RF17 | RNF02, RNF10 |
| US-15 | Estoque Solidário de Kimonos | Controle de Inventário | Como **Coordenador**, quero registrar cada doação de kimono que o projeto recebe e consultar quantos estão disponíveis a qualquer momento, para nunca ser pego de surpresa sem uniforme na hora de receber um aluno novo. | RF18, RF20 | RNF07 |
| US-16 | Estoque Solidário de Kimonos | Controle de Inventário | Como **Coordenador**, quero dar baixa em kimonos que foram danificados ou tornaram-se inutilizáveis, para que o estoque reflita apenas o que pode ser efetivamente emprestado. | RF19 | RNF07 |
| US-17 | Estoque Solidário de Kimonos | Empréstimos e Devoluções | Como **Coordenador**, quero registrar que um kimono saiu do estoque emprestado para um aluno específico, para saber exatamente onde cada uniforme está e evitar que materiais sumam sem rastro. | RF21 | RNF07 |
| US-18 | Estoque Solidário de Kimonos | Empréstimos e Devoluções | Como **Coordenador**, quero registrar a devolução de um kimono e reintegrá-lo ao estoque disponível, para que ele possa ser emprestado rapidamente a outro aluno que precisar. | RF22 | RNF07 |
| US-19 | Acompanhamento Pedagógico e Engajamento | Engajamento com a Comunidade | Como **Voluntário**, quero ver, logo que entro no sistema, quais alunos fazem aniversário naquela semana e ter essa lista carregada rapidamente, para que a equipe consiga celebrar com eles no treino e fortalecer o vínculo afetivo do projeto com as famílias. | RF30 | RNF01, RNF03 |
| US-20 | Acompanhamento Pedagógico e Engajamento | Engajamento com a Comunidade | Como **Voluntário**, quero registrar as orientações e os feedbacks que foram passados para os responsáveis de um aluno, para ter um histórico claro das conversas realizadas e não precisar confiar na memória de quem atendeu. | RF24 | - |
| US-21 | Acompanhamento Pedagógico e Engajamento | Registros e Observações Pedagógicas | Como **Voluntário**, quero anotar observações sobre o comportamento e o desenvolvimento de cada aluno, para que toda a equipe possa enxergar sua trajetória de forma integrada, sem depender de quem esteve presente em determinado treino. | RF23 | - |
| US-22 | Acompanhamento Pedagógico e Engajamento | Registros e Observações Pedagógicas | Como **Voluntário**, quero navegar pela linha do tempo dos registros pedagógicos de um aluno em ordem cronológica, para ter uma leitura clara de como seu acompanhamento foi evoluindo ao longo da sua trajetória no projeto. | RF27 | - |
| US-23 | Acompanhamento Pedagógico e Engajamento | Registros e Observações Pedagógicas | Como **Voluntário**, quero corrigir um registro pedagógico que foi lançado com algum erro e garantir que ele esteja devidamente associado ao perfil do aluno certo, para que o histórico de cada criança seja preciso e esteja sempre vinculado onde deve estar. | RF25, RF26 | - |
| US-24 | Acompanhamento Pedagógico e Engajamento | Evolução e Impacto Social | Como **Coordenador**, quero visualizar a trajetória completa de faixas e graduações de cada aluno ao longo do tempo, para reconhecer formalmente sua evolução dentro do jiu-jitsu e celebrar as conquistas com ele e com sua família. | RF29 | - |
| US-25 | Acompanhamento Pedagógico e Engajamento | Evolução e Impacto Social | Como **Coordenador**, quero gerar e exportar um relatório consolidado com os dados sociais e de vulnerabilidade dos alunos atendidos, para apresentar à comunidade e a potenciais doadores o real impacto humano do projeto. | RF28 | - |
| US-26 | Gestão de Campeonatos | Configuração de Eventos Competitivos | Como **Coordenador**, quero cadastrar e atualizar as informações de um campeonato — nome, data, local e demais detalhes —, para ter o projeto preparado para levar seus alunos a eventos com tudo devidamente registrado. | RF31, RF32 | - |
| US-27 | Gestão de Campeonatos | Configuração de Eventos Competitivos | Como **Coordenador**, quero encerrar um campeonato que foi finalizado ou cancelado, preservando quem participou e o que foi registrado, para manter um histórico fiel das competições que o projeto já disputou. | RF33 | - |
| US-28 | Gestão de Campeonatos | Participação dos Alunos em Competições | Como **Coordenador**, quero inscrever um aluno em um campeonato específico, para que sua participação esteja formalmente registrada e o projeto saiba exatamente quem vai representá-lo no evento. | RF34 | - |
| US-29 | Gestão de Campeonatos | Participação dos Alunos em Competições | Como **Coordenador**, quero retirar a inscrição de um aluno de um campeonato quando necessário, para que os registros de participação reflitam apenas quem de fato estará presente. | RF35 | - |
| US-30 | Gestão de Usuários e Acessos | Cadastro e Manutenção de Voluntários | Como **Coordenador**, quero cadastrar os voluntários do projeto e manter seus dados sempre atualizados, para ter à disposição os contatos e perfis de quem trabalha junto na iniciativa, com suas senhas protegidas desde o cadastro. | RF36, RF37 | RNF09 |
| US-31 | Gestão de Usuários e Acessos | Cadastro e Manutenção de Voluntários | Como **Coordenador**, quero inativar o acesso de um voluntário que não faz mais parte do projeto, mas preservar o histórico de tudo que ele fez, para garantir que apenas quem ainda atua continue acessando as informações das famílias. | RF38 | - |
| US-32 | Gestão de Usuários e Acessos | Controle de Acesso e Segurança | Como **Coordenador**, quero definir e ajustar o nível de permissão de cada voluntário no sistema, para que cada pessoa acesse e faça somente o que é adequado à sua função, protegendo os dados sensíveis dos alunos. | RF41 | RNF06 |
| US-33 | Gestão de Usuários e Acessos | Controle de Acesso e Segurança | Como **Voluntário**, quero encerrar minha sessão no sistema ao terminar o uso, para impedir que alguém acesse as informações das crianças pelo meu dispositivo depois que eu sair. | RF40 | - |
| US-34 | Gestão de Usuários e Acessos | Cadastro e Manutenção de Voluntários | Como **Coordenador**, quero buscar um voluntário pelo nome ou pela função que exerce, para localizar rapidamente o perfil de qualquer colaborador sem precisar percorrer toda a listagem de cadastros. | RF39 | - |

> **Nota 1:** O dimensionamento de esforço (Planning Poker), a avaliação de riscos, as dependências, a priorização (MoSCoW e Valor de Negócio) e os Critérios de Aceitação que definem o Produto Mínimo Viável (MVP) estão especificados taticamente na **Seção 10.2**.

> **Nota 2:** Os Requisitos Não Funcionais transversais **RNF05** (LGPD) e **RNF08** (Responsividade), que representam restrições de todo o sistema, não foram descritos como Histórias de Usuário individuais. Eles atuam como restrições arquiteturais e compõem a **Definition of Done (DoD)** que baliza o desenvolvimento de todas as histórias.




## 10.2 Priorização do Backlog Geral e MVP
