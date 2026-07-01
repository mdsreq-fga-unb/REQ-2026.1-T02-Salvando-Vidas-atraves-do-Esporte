import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/services/user_service/user_service.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';

part 'update_voluntario_store.g.dart';
part 'update_voluntario_store.mapper.dart';

@MappableClass()
class UpdateVoluntarioState with UpdateVoluntarioStateMappable {
  final String id;
  final String nome;
  final String email;
  final String telefone;
  final String senha;
  final String cpf;
  final String funcao;
  final Faixa faixa;
  final bool dirty;

  UpdateVoluntarioState({
    required this.id,
    this.nome = '',
    this.email = '',
    this.telefone = '',
    this.senha = '',
    this.cpf = '',
    this.funcao = '',
    this.faixa = Faixa.branca,
    this.dirty = false,
  });

  String? get nomeError => nome.trim().isEmpty ? 'Nome é obrigatório' : null;

  String? get emailError {
    if (email.isEmpty) return null;
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get telefoneError {
    if (telefone.isEmpty) return null;
    return eTelefone(telefone) ? null : 'Não é um telefone válido';
  }

  String? get cpfError {
    if (cpf.isEmpty) return null;
    return eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  String? get funcaoError =>
      funcao.trim().isEmpty ? 'Função é obrigatória' : null;

  bool get temErros =>
      nomeError != null ||
      emailError != null ||
      telefoneError != null ||
      cpfError != null;

  bool get podeCadastrar =>
      nome.isNotEmpty &&
      email.isNotEmpty &&
      telefone.isNotEmpty &&
      cpf.isNotEmpty &&
      !temErros;

  Map<String, dynamic> get diff => {
    'p_id': id,
    'p_email': email.trim().isEmpty ? null : email.trim(),
    'p_senha': senha.trim().isEmpty ? null : senha.trim(),
    'p_nome': nome.trim().isEmpty ? null : nome.trim(),
    'p_telefone': telefone.trim().isEmpty ? null : telefone.trim(),
    'p_cpf': cpf.trim().isEmpty ? null : cpf.trim(),
  };
}

@riverpod
class UpdateVoluntario extends _$UpdateVoluntario {
  @override
  UpdateVoluntarioState build() {
    final user = ref.read(userServiceProvider).localUser!;

    return UpdateVoluntarioState(
      id: user.id!,
      nome: user.nome,
      email: user.email,
      telefone: user.telefone,
      cpf: user.cpf,
      funcao: user.funcao,
      faixa: user.faixa,
    );
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
