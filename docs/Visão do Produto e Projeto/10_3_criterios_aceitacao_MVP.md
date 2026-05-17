# 10.3 Critérios de Aceitação do MVP

Os Critérios de Aceitação (CA) definem as condições mínimas para que cada História de Usuário do MVP seja considerada concluída. Os RNFs transversais (LGPD, responsividade) compõem a Definition of Done e se aplicam a todas as histórias. Esses critérios não são estáticos: são continuamente validados e refinados junto aos stakeholders ao longo dos ciclos iterativos.

---

## Gestão de Alunos e Responsáveis

**US-01** — Cadastro e Manutenção de Dados Cadastrais

- Campos obrigatórios do aluno e do responsável devem ser validados antes de salvar.
- O sistema confirma o cadastro bem-sucedido.
- O aluno recém-cadastrado é encontrado imediatamente pela busca por nome.

**US-02** — Cadastro e Manutenção de Dados Cadastrais

- Qualquer campo do cadastro pode ser editado, com alterações salvas imediatamente.
- A inativação exige confirmação e não exclui os dados.
- Cadastros inativos ficam ocultos nas listagens ativas, mas acessíveis para consulta histórica.

**US-03** — Vínculos entre Aluno e Responsável

- Um responsável cadastrado podem ser vinculado a um ou mais alunos.
- O perfil do aluno exibe todos os responsáveis vinculados com nome e parentesco.
- Não é possível vincular um responsável não cadastrado.

**US-04** — Vínculos entre Aluno e Responsável

- O vínculo pode ser removido mediante confirmação.
- A remoção do vínculo não exclui o cadastro do responsável.
- O responsável desvinculado deixa de aparecer no perfil do aluno.

---

## Gestão de Turmas

**US-05** — Criação e Manutenção de Turmas

- Campos obrigatórios (nome, dias, horário, faixa etária, professor) são validados antes de salvar.
- Qualquer configuração de uma turma pode ser editada a qualquer momento.
- Alterações são refletidas imediatamente em todas as visualizações.

**US-06** — Criação e Manutenção de Turmas

- O encerramento de uma turma exige confirmação.
- Turmas encerradas não aceitam novos registros de presença nem matrículas.
- Histórico de aulas e alunos da turma é preservado após o encerramento.

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
- Cada marcação (presente/ausente) é confirmada em menos de 1 segundo.
- Não é possível registrar presença em turma encerrada ou data futura.

**US-11** — Registro de Presença em Aula

- O status de presença de um registro já lançado pode ser corrigido.
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
- Cada devolução gera log de auditoria com data e aluno.

---

## Acompanhamento Pedagógico e Engajamento

**US-19** — Engajamento com a Comunidade

- A lista de aniversariantes da semana é exibida no dashboard em até 3 segundos após o login.
- A lista exibe nome e data de aniversário; ausência de aniversariantes exibe mensagem informativa.

---

## Gestão de Usuários e Acessos

**US-30** — Cadastro e Manutenção de Voluntários

- Campos obrigatórios (nome, função, contato, senha) são validados antes de salvar.
- A senha é armazenada com criptografia AES-256.
- Os dados do voluntário podem ser editados a qualquer momento.

**US-31** — Cadastro e Manutenção de Voluntários

- A inativação exige confirmação e impede o login do voluntário imediatamente.
- O histórico de ações do voluntário inativo é preservado e acessível.

**US-32** — Controle de Acesso e Segurança

- O sistema oferece ao menos dois perfis: Coordenador e Voluntário.
- Cada usuário acessa somente as funcionalidades do seu perfil; tentativas fora do perfil são bloqueadas.
- Apenas usuários autenticados acessam telas protegidas.

**US-33** — Controle de Acesso e Segurança

- A opção de logout está disponível em todas as telas.
- O logout invalida a sessão imediatamente e redireciona para a tela de login.
- Após o logout, nenhuma tela protegida é acessível sem novo login.
