# Critérios de Aceitação

## Gestão de Alunos

### US-01 — Cadastro e Manutenção de Dados Cadastrais

* O sistema deve validar o preenchimento dos campos obrigatórios (Nome, CPF, Telefone, Contato de emergência, Email, Aniversário, Tipo Sanguíneo, Faixa/Grau) antes de concluir o cadastro do aluno.
* Quando o aluno for menor de idade, o sistema deve solicitar o preenchimento dos dados do responsável.
* Deve haver campos opcionais para inserção de apelido e ID da ficha física.

### US-02 — Cadastro e Manutenção de Dados Cadastrais

* O aluno deve ser localizado pela funcionalidade de busca utilizando seu nome.
* O sistema deve permitir a edição dos dados cadastrais do aluno a qualquer momento.
* Deve haver confirmação da intenção de salvar alterações realizadas.


### US-03 — Cadastro e Manutenção de Dados Cadastrais

* O sistema deve solicitar confirmação antes de realizar a inativação do cadastro do aluno.
* Cadastros inativos não devem ser exibidos nas listagens de alunos ativos.
* Após a reativação, o cadastro do aluno deve retornar ao status "Ativo" e voltar a ser exibido nas listagens do sistema com o histórico de informações preservado.


---

## Gestão de Turmas

### US-07 — Matrículas e Participação em Turmas

* O sistema deve permitir a matrícula apenas de alunos com cadastro ativo.
* Após a matrícula, o aluno deve ser incluído automaticamente na lista de chamada da turma correspondente.
* O sistema não deve permitir que um aluno possua matrícula ativa em mais de uma turma simultaneamente.

### US-08 — Matrículas e Participação em Turmas

* O sistema deve solicitar confirmação antes de concluir o cancelamento da matrícula do aluno.
* Após o cancelamento da matrícula, o aluno não deve aparecer nas listas de chamada futuras da turma.
* O sistema deve preservar o histórico de presença anterior ao cancelamento, caso o aluno seja matriculado novamente na mesma turma.

---

## Controle de Frequência e Evasão

### US-09 — Registro de Presença em Aula

* O sistema deve exibir a lista de alunos matriculados na turma para realização da chamada.
* O sistema deve exigir que um instrutor ou professor esteja vinculado ao registro de frequência da aula.
* O sistema não deve permitir o registro de presença para datas futuras.

### US-10 — Correção de Registro de Presença

* O status de presença de um registro já lançado pode ser alterado pelo voluntário.
* O sistema deve exibir ao voluntário o status de presença atualizado imediatamente após a confirmação da alteração.
* A correção deve ser refletida imediatamente no histórico do aluno.

### US-12 — Monitoramento e Prevenção à Evasão

* O sistema deve permitir a consulta ao histórico de frequência do aluno com opção de filtro por período.
* O histórico de frequência deve exibir, para cada registro, a data da aula e o status de presença do aluno.
* O sistema deve apresentar o total acumulado de presenças e ausências do aluno no período consultado.

### US-13 — Monitoramento e Prevenção à Evasão

* O sistema deve exibir no painel principal um contador com o total de alunos que possuem duas ou mais semanas consecutivas de ausência.
* O sistema deve aplicar um destaque visual aos alunos identificados como em risco de evasão nas listagens gerais.
* O destaque visual deve ser removido automaticamente após o registro de uma nova presença do aluno.

---

## Estoque Solidário de Kimonos

### US-14 — Controle de Inventário

* O sistema deve permitir o registro de doações contendo, no mínimo, tamanho, cor, quantidade e nome do doador.
* Após o registro da doação, o sistema deve atualizar automaticamente a quantidade disponível no estoque.
* O sistema não deve permitir o registro de doações com campos obrigatórios vazios ou com quantidade igual ou inferior a zero.

### US-15 — Controle de Inventário

* O sistema deve exigir a seleção do kimono danificado ou perdido antes do registro da ocorrência.
* O sistema deve solicitar o motivo da perda ou dano e a quantidade de itens afetados.
* O sistema deve concluir o registro apenas quando todos os campos obrigatórios estiverem preenchidos.

### US-16 — Empréstimos e Devoluções

* O sistema deve vincular o empréstimo do kimono a um aluno com cadastro ativo e removê-lo automaticamente do estoque disponível.
* O sistema não deve permitir o empréstimo de kimonos indisponíveis no estoque.
* O sistema deve permitir apenas um empréstimo ativo de kimono por aluno.

### US-17 — Empréstimos e Devoluções

* O sistema deve reintegrar automaticamente o kimono ao estoque disponível após o registro da devolução.
* O sistema não deve permitir o registro da devolução de um kimono que não possua empréstimo ativo.
* O sistema deve exibir a lista de alunos com empréstimos ativos para seleção durante o processo de devolução.

---

## Acompanhamento Pedagógico e Engajamento

### US-18 — Engajamento com a Comunidade

* O sistema deve exibir automaticamente a lista de aniversariantes da semana no dashboard após a autenticação do usuário.
* A lista de aniversariantes deve apresentar claramente o nome do aluno e a quantidade de dias restantes até o aniversário.
* Caso não existam aniversariantes na semana corrente, o sistema deve exibir uma mensagem informativa ao usuário.

---

## Gestão de Usuários e Acessos

### US-28 — Cadastro e Manutenção de Voluntários

* O sistema deve permitir o cadastro de voluntários contendo, no mínimo, os campos: nome, CPF, telefone de contato, telefone de emergência, e-mail e faixa de graduação.
* O sistema deve validar o preenchimento dos campos obrigatórios antes de concluir o cadastro do voluntário.
* O sistema deve permitir a edição dos dados do voluntário a qualquer momento, exceto do CPF, que deve permanecer imutável após o cadastro.

### US-29 — Inativação e Reativação de Voluntários

* O sistema deve exigir uma confirmação do usuário antes de concluir a inativação do voluntário.
* Após a inativação, o voluntário não deve conseguir acessar o sistema até que seu cadastro seja reativado.
* O sistema deve permitir a reativação do voluntário preservando todo o histórico e informações previamente cadastradas.

### US-31 — Controle de Acesso e Segurança

* O sistema deve solicitar um endereço de e-mail e uma senha válidos para realizar a autenticação do usuário.
* Quando as credenciais informadas forem válidas, o sistema deve autenticar o usuário e redirecioná-lo para a tela inicial.
* Quando as credenciais informadas forem inválidas, o sistema deve impedir o acesso e exibir uma mensagem indicando credenciais incorretas.

### US-32 — Controle de Acesso e Segurança

* O sistema deve solicitar a confirmação do usuário antes de realizar o encerramento da sessão.
* Após a confirmação do logout, o sistema deve invalidar imediatamente a sessão ativa e redirecionar o usuário para a tela de login.
* Após o logout, o sistema não deve permitir o acesso a telas protegidas sem que uma nova autenticação seja realizada.