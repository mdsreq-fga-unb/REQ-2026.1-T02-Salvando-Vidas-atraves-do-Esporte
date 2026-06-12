import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

part 'cadastro_voluntario_form.g.dart';
part 'cadastro_voluntario_form.mapper.dart';

@MappableClass()
class CadastroVoluntarioState with CadastroVoluntarioStateMappable {
  final String nome;
  final String email;
  final String telefone;
  final String senha;
  final String cpf;
  final bool dirty;

  CadastroVoluntarioState({
    this.nome = '',
    this.email = '',
    this.telefone = '',
    this.senha = '',
    this.cpf = '',
    this.dirty = false,
  });

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

  bool get temErros =>
      nomeError != null ||
      emailError != null ||
      telefoneError != null ||
      senhaError != null ||
      cpfError != null;

  bool get podeCadastrar =>
      nome.isNotEmpty &&
      email.isNotEmpty &&
      telefone.isNotEmpty &&
      senha.isNotEmpty &&
      cpf.isNotEmpty &&
      !temErros;

  LocalUser get voluntario => LocalUser(
    role: Role.voluntario,
    nome: nome,
    telefone: telefone,
    cpf: cpf,
    email: email,
    senha: senha,
  );
}

@riverpod
class CadastroVoluntario extends _$CadastroVoluntario {
  @override
  CadastroVoluntarioState build() {
    return CadastroVoluntarioState();
  }

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
