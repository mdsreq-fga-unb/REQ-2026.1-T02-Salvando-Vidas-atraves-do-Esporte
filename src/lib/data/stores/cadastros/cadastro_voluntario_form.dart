import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

part 'cadastro_voluntario_form.g.dart';

// 1. Classe de Estado Imutável
class CadastroVoluntarioFormState {
  final String nome;
  final String email;
  final String telefone;
  final String senha;
  final String cpf;
  final bool dirty; // Evita que os campos fiquem vermelhos antes da digitação

  CadastroVoluntarioFormState({
    this.nome = '',
    this.email = '',
    this.telefone = '',
    this.senha = '',
    this.cpf = '',
    this.dirty = false,
  });

  // Os erros agora são getters calculados sob demanda, substituindo os @actions do MobX
  String? get nomeError {
    if (!dirty && nome.isEmpty) return null;
    return nome.isNotEmpty ? null : 'Não pode estar em branco';
  }

  String? get emailError {
    if (!dirty && email.isEmpty) return null;
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get telefoneError {
    if (!dirty && telefone.isEmpty) return null;
    return eTelefone(telefone) ? null : 'Não é um telefone válido';
  }

  String? get senhaError {
    if (!dirty && senha.isEmpty) return null;
    return senha.isNotEmpty ? null : 'Não pode estar em branco';
  }

  String? get cpfError {
    if (!dirty && cpf.isEmpty) return null;
    return eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  // Equivalente ao antigo getter temErros do MobX
  bool get temErros =>
      nomeError != null ||
      emailError != null ||
      telefoneError != null ||
      senhaError != null ||
      cpfError != null;

  // Equivalente ao antigo @computed podeCadastrar
  bool get podeCadastrar =>
      nome.isNotEmpty &&
      email.isNotEmpty &&
      telefone.isNotEmpty &&
      senha.isNotEmpty &&
      cpf.isNotEmpty &&
      !temErros;

  // Mantido o helper para gerar o LocalUser
  LocalUser get voluntario => LocalUser(
    role: Role.voluntario,
    nome: nome,
    telefone: telefone,
    cpf: cpf,
    email: email,
    senha: senha,
  );

  CadastroVoluntarioFormState copyWith({
    String? nome,
    String? email,
    String? telefone,
    String? senha,
    String? cpf,
    bool? dirty,
  }) {
    return CadastroVoluntarioFormState(
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      senha: senha ?? this.senha,
      cpf: cpf ?? this.cpf,
      dirty: dirty ?? this.dirty,
    );
  }
}

// 2. O Notifier gerenciador do estado
@riverpod
class CadastroVoluntarioForm extends _$CadastroVoluntarioForm {
  @override
  CadastroVoluntarioFormState build() {
    return CadastroVoluntarioFormState();
  }

  // Métodos de atualização chamados pelos TextFields
  void updateNome(String value) {
    state = state.copyWith(nome: value, dirty: true);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, dirty: true);
  }

  void updateTelefone(String value) {
    state = state.copyWith(telefone: value, dirty: true);
  }

  void updateSenha(String value) {
    state = state.copyWith(senha: value, dirty: true);
  }

  void updateCpf(String value) {
    state = state.copyWith(cpf: value, dirty: true);
  }
}
