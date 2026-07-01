import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
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
  final String funcao;
  final Faixa faixa;
  final bool dirty;

  CadastroVoluntarioState({
    this.nome = '',
    this.email = '',
    this.telefone = '',
    this.senha = '',
    this.cpf = '',
    this.funcao = '',
    this.faixa = Faixa.branca,
    this.dirty = false,
  });

  String? get nomeError => null;

  String? get emailError {
    if (email.isEmpty) return null;
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get telefoneError {
    if (telefone.isEmpty) return null;
    return eTelefone(telefone) ? null : 'Não é um telefone válido';
  }

  String? get senhaError => null;

  String? get cpfError {
    if (cpf.isEmpty) return null;
    return eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  String? get funcaoError => null;

  bool get temErros =>
      nomeError != null ||
      emailError != null ||
      telefoneError != null ||
      cpfError != null ||
      senhaError != null;

  bool get podeCadastrar =>
      nome.isNotEmpty &&
      email.isNotEmpty &&
      telefone.isNotEmpty &&
      cpf.isNotEmpty &&
      senha.isNotEmpty &&
      !temErros;

  LocalUser get voluntario => LocalUser(
    role: Role.voluntario,
    nome: nome,
    telefone: telefone,
    cpf: cpf,
    email: email,
    senha: senha,
    funcao: funcao,
    faixa: faixa,
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

  void updateFuncao(String value) {
    state = state.copyWith(funcao: value, dirty: true);
  }

  void updateFaixa(Faixa value) {
    state = state.copyWith(faixa: value, dirty: true);
  }
}
