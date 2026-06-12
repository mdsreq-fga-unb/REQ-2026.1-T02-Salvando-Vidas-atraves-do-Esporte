import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';

part 'cadastro_aluno.g.dart';
part 'cadastro_aluno.mapper.dart';

@MappableClass()
class CadastroAlunoState with CadastroAlunoStateMappable {
  final String nome;
  final String cpf;
  final String contato;
  final String email;
  final DateTime? nascimento;
  final TipoSanguineo? tipoSanguineo;
  final Faixa? faixa;
  final int grau = 0;
  final bool dirty;

  final String nomeResponsavel;
  final String cpfResponsavel;
  final String contatoResponsavel;
  final String emailResponsavel;

  CadastroAlunoState({
    this.nome = '',
    this.cpf = '',
    this.contato = '',
    this.email = 'aluno@gmail.com',
    this.nascimento,
    this.tipoSanguineo,
    this.faixa,
    this.nomeResponsavel = '',
    this.cpfResponsavel = '',
    this.contatoResponsavel = '',
    this.emailResponsavel = 'responsavel@gmail.com',
    this.dirty = false,
  });

  String? get nomeError {
    if (!dirty && nome.isEmpty) return null;
    return nome.isNotEmpty ? null : 'Não pode estar em branco';
  }

  String? get nomeResponsavelError {
    if (!dirty && nomeResponsavel.isEmpty) return null;
    return nomeResponsavel.isNotEmpty ? null : 'Não pode estar em branco';
  }

  String? get cpfError {
    if (!dirty && cpf.isEmpty) return null;
    return eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  String? get cpfResponsavelError {
    if (!dirty && cpfResponsavel.isEmpty) return null;
    return eCPF(cpfResponsavel) ? null : 'Não é um CPF válido';
  }

  String? get contatoError {
    if (!dirty && contato.isEmpty) return null;
    return eTelefone(contato) ? null : 'Não é um telefone válido';
  }

  String? get contatoResponsavelError {
    if (!dirty && contatoResponsavel.isEmpty) return null;
    return eTelefone(contatoResponsavel) ? null : 'Não é um telefone válido';
  }

  String? get nascimentoError {
    if (!dirty && nascimento == null) return null;
    return nascimento != null ? null : 'Não pode estar em branco';
  }

  String? get tipoSanguineoError {
    if (!dirty && tipoSanguineo == null) return null;
    return tipoSanguineo != null ? null : 'Não pode estar em branco';
  }

  String? get faixaError {
    if (!dirty && faixa == null) return null;
    return faixa != null ? null : 'Não pode estar em branco';
  }

  bool get temErros =>
      nomeError != null ||
      cpfError != null ||
      contatoError != null ||
      nascimentoError != null ||
      tipoSanguineoError != null ||
      faixaError != null;

  int get idade {
    final agora = DateTime.now().year;
    return agora - (nascimento?.year ?? agora);
  }

  bool get temResponsavel {
    if (idade >= 18) return true;
    return nomeResponsavelError == null &&
        cpfResponsavelError == null &&
        contatoResponsavelError == null;
  }

  Aluno get aluno => Aluno(
    nome: nome,
    cpf: cpf,
    contato: contato,
    email: email,
    nascimento: nascimento!,
    tipoSanguineo: tipoSanguineo!,
    faixa: faixa!,
    grau: grau,
    ativo: true,
    federado: false,
    dataEntrada: DateTime.now(),
  );

  Responsavel get responsavel => Responsavel(
    nome: nomeResponsavel!,
    cpf: cpfResponsavel!,
    contato: contatoResponsavel!,
    email: emailResponsavel!,
    ativo: true,
  );
}

@riverpod
class CadastroAluno extends _$CadastroAluno {
  @override
  CadastroAlunoState build() {
    return CadastroAlunoState();
  }

  void updateNome(String value) {
    state = state.copyWith(nome: value, dirty: true);
  }

  void updateCPF(String value) {
    state = state.copyWith(cpf: value, dirty: true);
  }

  void updateContato(String value) {
    state = state.copyWith(contato: value, dirty: true);
  }

  void updateNascimento(DateTime value) {
    state = state.copyWith(nascimento: value, dirty: true);
  }

  void updateTipoSanguineo(TipoSanguineo value) {
    state = state.copyWith(tipoSanguineo: value, dirty: true);
  }

  void updateFaixa(Faixa value) {
    state = state.copyWith(faixa: value, dirty: true);
  }

  void updateNomeResponsavel(String value) {
    state = state.copyWith(nomeResponsavel: value, dirty: true);
  }

  void updateCPFResponsavel(String value) {
    state = state.copyWith(cpfResponsavel: value, dirty: true);
  }

  void updateContatoResponsavel(String value) {
    state = state.copyWith(contatoResponsavel: value, dirty: true);
  }

  void reset() {
    state = CadastroAlunoState();
  }
}
