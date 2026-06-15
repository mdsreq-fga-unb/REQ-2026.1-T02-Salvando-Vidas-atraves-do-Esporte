# 10.3 Critérios de Aceitação do MVP

Os Critérios de Aceitação (CA) definem as condições mínimas para que cada História de Usuário do MVP seja considerada concluída. Os RNFs transversais compõem a Definition of Done e se aplicam a todas as histórias. Esses critérios não são estáticos: são continuamente validados e refinados junto aos stakeholders ao longo dos ciclos iterativos.

---

## Gestão de Alunos e Responsáveis

**US-01** — Cadastro e Manutenção de Dados Cadastrais

- Campos obrigatórios do aluno e do responsável devem ser validados antes de salvar.
- O sistema confirma o cadastro bem-sucedido.
- O aluno recém-cadastrado é encontrado pela busca por nome.

**US-02** — Cadastro e Manutenção de Dados Cadastrais

- Qualquer campo do cadastro pode ser editado, com alterações salvas imediatamente.
- A inativação exige confirmação e não exclui os dados.
- Cadastros inativos ficam ocultos nas listagens ativas, mas acessíveis para consulta histórica.

**US-03** — Vínculos entre Aluno e Responsável

- Um responsável pode ser vinculado a um ou mais alunos.
- O sistema deve exigir a vinculação de um responsável legal caso a data de nascimento informe que o aluno é menor de 18 anos.
- O perfil do aluno exibe o responsável vinculado.


**US-04** — Vínculos entre Aluno e Responsável

- O vínculo pode ser removido mediante confirmação.
- A remoção do vínculo não exclui o cadastro do responsável.
- O responsável desvinculado deixa de aparecer no perfil do aluno.

**US-36** — Vínculos entre Aluno e Responsável
- O sistema deve permitir localizar alunos e responsáveis inativos.
- A reativação deve exigir confirmação do Coordenador.
- Após a confirmação, o cadastro deve retornar ao status "Ativo" e às listagens do sistema.
- O histórico do aluno e os vínculos com responsáveis devem ser preservados.


---
## Gestão de Turmas

**US-08** — Matrículas e Participação em Turmas

- Somente alunos ativos podem ser matriculados em turmas ativas.
- O aluno matriculado aparece automaticamente na lista de chamada da turma.

**US-09** — Matrículas e Participação em Turmas

- O cancelamento da matrícula exige confirmação.
- O aluno desmatriculado não aparece em chamadas futuras da turma.
- O histórico de presença anterior ao cancelamento é preservado.


---

## Controle de Frequência e Evasão

**US-10** — Registro de Presença em Aula

- A lista de alunos matriculados é exibida para registro de chamada.
- Cada marcação é confirmada em menos de 1 segundo.
- Não é possível registrar presença em turma encerrada ou data futura.

**US-11** — Registro de Presença em Aula

- O status de presença de um registro já lançado pode ser alterado pelo Voluntário
- A correção é refletida imediatamente no histórico do aluno.

**US-13** — Monitoramento e Prevenção à Evasão

- O histórico de frequência de um aluno pode ser consultado com filtro por período.
- O resultado exibe data, turma e status de cada aula, além do total de presenças e ausências.

**US-14** — Monitoramento e Prevenção à Evasão

- O sistema gera automaticamente a lista de alunos com 2 semanas consecutivas de falta.
- A lista exibe nome, turma e semanas consecutivas de ausência.
- Os indicadores são atualizados e exibidos em menos de 3 segundos.

---

## Estoque Solidário de Kimonos

**US-15** — Controle de Inventário

- Doações são registradas com tamanho, quantidade e data; quantidade zero ou negativa é bloqueada.
- O estoque disponível para empréstimo é exibido de forma atualizada.
- Cada entrada gera um log de auditoria.

**US-16** — Controle de Inventário

- A baixa por dano exige confirmação e não pode exceder o estoque atual.
- Kimonos baixados não aparecem no estoque disponível.
- Cada baixa gera um log de auditoria com motivo, quantidade e data.

**US-17** — Empréstimos e Devoluções

- O empréstimo vincula o kimono a um aluno ativo e o retira do estoque disponível.
- Não é possível emprestar kimono indisponível em estoque.
- Um aluno poderá ter apenas um empréstimo ativo.
- O perfil do aluno exibe o empréstimo ativo
- Cada empréstimo gera log de auditoria com data, kimono e aluno vinculado.

**US-18** — Empréstimos e Devoluções

- A devolução reintegra o kimono ao estoque disponível.
- Não é possível registrar devolução de kimono que não esteja emprestado.
- O formulário de devolução deve possuir uma opção (ex: checkbox) para registrar "Devolvido com dano" direcionando o item automaticamente para a baixa, impedindo que volte ao estoque disponível.
- Cada devolução gera log de auditoria com data e aluno.

---

## Acompanhamento Pedagógico e Engajamento

**US-19** — Engajamento com a Comunidade

- A lista de aniversariantes da semana é exibida no dashboard em até 3 segundos após o login.
- A lista de aniversariantes deve exibir claramente o nome do aluno e a quantidade de dias restantes para o aniversário.
- Caso não existam aniversariantes na semana, o sistema deve exibir uma mensagem informando.

---

## Gestão de Usuários e Acessos

**US-30** — Cadastro e Manutenção de Voluntários

- Campos obrigatórios são validados antes de salvar.
- A senha é armazenada com criptografia.
- Os dados do voluntário podem ser editados a qualquer momento.

**US-31** — Cadastro e Manutenção de Voluntários

- A inativação exige confirmação e impede o login do voluntário imediatamente.
- O histórico de ações do voluntário inativo é preservado e acessível.

**US-33** — Controle de Acesso e Segurança

- O sistema oferece ao menos dois perfis: Coordenador e Voluntário.
- O sistema não deve exibir no menu ou nas telas as funcionalidades e botões que estejam fora do nível de permissão do usuário autenticado.
- Apenas usuários autenticados acessam telas protegidas.

**US-34** — Controle de Acesso e Segurança

- O logout invalida a sessão imediatamente e redireciona para a tela de login.
- Após o logout, nenhuma tela protegida é acessível sem novo login.

**US-35** — Controle de Acesso e Segurança

- O sistema deve solicitar um e-mail e uma senha válidos para a autenticação.
- Se credenciais corretas, o usuário deve ser autenticado e redirecionado para a tela inicial.
- Se credenciais incorretas, o sistema deve bloquear o acesso e exibir uma mensagem de erro genérica.
