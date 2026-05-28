# DoR e DoD

## 9.1 Definition of Ready (DoR)

O DoR é um conjunto de critérios que indicam quando um requisito está pronto para ser trabalhado no *Design* de Usuário e na Construção Rápida. Também é o acordo entre a equipe de desenvolvimento e o cliente que garante clareza e alinhamento, minimizando o desenvolvimento de código que não atenda às necessidades do projeto. Os critérios do DoR estão estruturados como uma lista de perguntas a serem respondidas antes de um requisito ser considerado pronto, dispostas abaixo:

- **O requisito está devidamente documentado?**  
O requisito deve estar associado a uma *User Story*, Épico e Tema, e deve estar atualizado nas páginas de [Requisitos](./requisitosDeSoftware.md) e [Backlog](./10_1_backlog_geral.md).

- **O requisito é viável em termos de tempo e complexidade?**  
O requisito deve ter sido avaliado pela equipe de desenvolvimento quanto à complexidade e ao tempo necessário para implementá-lo, utilizando o *Planning Poker* para realizar essas estimativas.

- **O requisito foi priorizado?**  
O requisito deve ter sido priorizado pelos clientes utilizando a técnica MoSCoW, com a decisão documentada em ata ou vídeo e registrada no backlog.

- **O requisito está claro e delimitado?**  
O requisito deve definir o fluxo principal da funcionalidade, detalhando quais são as entradas necessárias, as saídas geradas pelo sistema e as restrições (o que o sistema não deve fazer). O alinhamento sobre essas definições deve estar registrado em ata ou vídeo.

- **A *User Story* foi prototipada?**  
Para *User Stories* que resultem no desenvolvimento de uma interface visual, deve haver um protótipo de baixa fidelidade associado a ela, o qual precisa ter sido previamente validado pelos clientes.

- **A *User Story* é testável e rastreável?**  
As *User Stories* presentes no MVP devem ter critérios de aceite testáveis e estar associadas a uma *Issue* no GitHub Projects do projeto.

- **A *User Story* foi validada pelo cliente?**  
A *User Story* deve ter sido validada pelos clientes e a aprovação deve estar registrada em ata ou vídeo.

## 9.2 Definition of Done (DoD)

O *Definition of Done (DoD)* é um conjunto de critérios estabelecidos pela equipe para determinar quando uma entrega (história, requisito ou incremento) pode ser considerada concluída. O conceito de “Done” indica que a funcionalidade foi desenvolvida, testada, validada e documentada, garantindo qualidade, rastreabilidade e alinhamento com as expectativas do cliente.

Os itens que devem ser verificados para determinar se um requisito está *“Done”* consistem em critérios de aceite claros, verificáveis e alinhados com o comportamento esperado da entrega.

- **A funcionalidade implementada está completa e atende aos requisitos?**  
A funcionalidade deve atender a todos os critérios de aceitação definidos na *User Story* e implementar todas as regras de negócio associadas, utilizando o *checklist* de critérios presente na *Issue*.

- **O código passou por revisão?**  
O código produzido para a *User Story* deve ter sido revisado e aprovado via *Pull Request* por pelo menos um outro desenvolvedor da equipe.

- **Os testes automatizados foram executados e passaram?**  
Cada *User Story* trabalhada deve contar com testes unitários (no mínimo testes de caixa preta cobrindo os fluxos de funcionamento válidos e inválidos) e testes de interface cobrindo o fluxo esperado de funcionamento. Tanto os testes recém-criados quanto os legados devem passar com sucesso. A execução deve ser documentada na *Issue* da *User Story* ou, caso não tenha sido realizada, o motivo deve ser detalhado.

- **Os *workflows* do projeto foram executados com sucesso?**  
Os *workflows* de *build* do projeto devem gerar os binários de instalação totalmente funcionais, tanto para *Android* quanto para *Windows*, além de disponibilizar a versão atualizada do site no *Vercel*. O *workflow* também deve criar uma *Release* automática no GitHub contendo os respectivos binários.

- **A documentação foi atualizada?**  
A documentação do projeto deve ser atualizada, evidenciando o cumprimento da entrega com provas do que foi feito.

- **A funcionalidade foi testada e aprovada pelo cliente?**  
O cliente deve ter testado a funcionalidade implementada em seu próprio dispositivo e validado a entrega formalmente.

> Uma entrega somente será considerada concluída quando atender aos critérios definidos neste DoD, estiver funcional, validada, documentada e aprovada pelo cliente.
