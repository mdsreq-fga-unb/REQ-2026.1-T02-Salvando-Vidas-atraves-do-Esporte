import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/domain/responsavel/responsavel.dart';

part 'update_aluno.g.dart';
part 'update_aluno.mapper.dart';

@MappableClass()
class UpdateAlunoState with UpdateAlunoStateMappable {
  final String nome;
  final String? apelido;
  final bool usarApelido;
  final String cpf;
  final String contato;
  final String contatoEmergencia;
  final String email;
  final DateTime? nascimento;
  final TipoSanguineo? tipoSanguineo;
  final Faixa? faixa;
  final int grau;
  final String idFicha;
  final int? idTurma;
  final bool dirty;

  final String nomeResponsavel;
  final String cpfResponsavel;
  final String contatoResponsavel;
  final String emailResponsavel;

  final Aluno alunoOriginal;
  final Responsavel? responsavelOriginal;

  UpdateAlunoState({
    required this.alunoOriginal,
    required this.responsavelOriginal,
    this.nome = '',
    this.apelido,
    this.usarApelido = false,
    this.cpf = '',
    this.contato = '',
    this.contatoEmergencia = '',
    this.email = '',
    this.nascimento,
    this.tipoSanguineo,
    this.faixa,
    this.grau = 0,
    this.idFicha = '',
    this.idTurma,
    this.nomeResponsavel = '',
    this.cpfResponsavel = '',
    this.contatoResponsavel = '',
    this.emailResponsavel = '',
    this.dirty = false,
  });

  String? get nomeError {
    if (nome == alunoOriginal.nome) return null;
    return nome.isNotEmpty ? null : 'Não pode estar em branco';
  }

  String? get nomeResponsavelError {
    if (nomeResponsavel == responsavelOriginal?.nome) return null;
    return nomeResponsavel.isNotEmpty ? null : 'Não pode estar em branco';
  }

  String? get cpfError {
    if (cpf == alunoOriginal.cpf) return null;
    return eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  String? get cpfResponsavelError {
    if (cpfResponsavel == responsavelOriginal?.cpf) return null;
    return eCPF(cpfResponsavel) ? null : 'Não é um CPF válido';
  }

  String? get contatoError {
    if (contato == alunoOriginal.contato) return null;
    return eTelefone(contato) ? null : 'Não é um telefone válido';
  }

  String? get contatoEmergenciaError {
    if (contatoEmergencia == alunoOriginal.contatoEmergencia) return null;
    return eTelefone(contatoEmergencia) ? null : 'Não é um telefone válido';
  }

  String? get contatoResponsavelError {
    if (contatoResponsavel == responsavelOriginal?.contato) return null;
    return eTelefone(contatoResponsavel) ? null : 'Não é um telefone válido';
  }

  String? get emailError {
    if (email == alunoOriginal.email) return null;
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get emailResponsavelError {
    if (emailResponsavel == responsavelOriginal?.email) return null;
    return eEmail(emailResponsavel) ? null : 'Não é um email válido';
  }

  String? get nascimentoError {
    if (!dirty) return null;
    return nascimento != null ? null : 'Não pode estar em branco';
  }

  String? get tipoSanguineoError {
    if (!dirty) return null;
    return tipoSanguineo != null ? null : 'Não pode estar em branco';
  }

  String? get faixaError {
    if (!dirty) return null;
    return faixa != null ? null : 'Não pode estar em branco';
  }

  String? get idFichaError {
    if (idFicha.isEmpty) return null;
    return int.tryParse(idFicha) != null
        ? null
        : 'O ID da ficha deve ser um número';
  }

  bool get temErros =>
      nomeError != null ||
      cpfError != null ||
      contatoError != null ||
      contatoEmergenciaError != null ||
      emailError != null ||
      nascimentoError != null ||
      tipoSanguineoError != null ||
      faixaError != null ||
      idFichaError != null;

  bool get estaValido =>
      !temErros &&
      nome.isNotEmpty &&
      cpf.isNotEmpty &&
      contato.isNotEmpty &&
      contatoEmergencia.isNotEmpty &&
      email.isNotEmpty;

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
    id: alunoOriginal.id,
    nome: nome,
    apelido: apelido,
    usarApelido: usarApelido,
    cpf: cpf,
    contato: contato,
    contatoEmergencia: contatoEmergencia,
    email: email,
    nascimento: nascimento!,
    tipoSanguineo: tipoSanguineo!,
    faixa: faixa!,
    grau: grau,
    ativo: alunoOriginal.ativo,
    federado: alunoOriginal.federado,
    dataEntrada: alunoOriginal.dataEntrada,
    idFicha: int.tryParse(idFicha),
    idTurma: idTurma,
    pMedica1: alunoOriginal.pMedica1,
    pMedica2: alunoOriginal.pMedica2,
    pMedica3: alunoOriginal.pMedica3,
    pMedica4: alunoOriginal.pMedica4,
    pMedica5: alunoOriginal.pMedica5,
    observacaoMedica: alunoOriginal.observacaoMedica,
  );

  Map<String, dynamic> diffAluno(Aluno aluno) {
    final original = alunoOriginal.toMap();
    final novo = aluno.toMap();

    for (final key in original.keys) {
      if (novo[key] == original[key]) {
        novo.remove(key);
      }
    }

    novo.remove('id');

    return novo;
  }

  Responsavel get responsavel => Responsavel(
    nome: nomeResponsavel,
    cpf: cpfResponsavel,
    contato: contatoResponsavel,
    email: emailResponsavel,
    ativo: true,
  );
}

@riverpod
class UpdateAluno extends _$UpdateAluno {
  @override
  UpdateAlunoState build(Aluno aluno, Responsavel? responsavel) {
    return UpdateAlunoState(
      alunoOriginal: aluno,
      responsavelOriginal: responsavel,
      nome: aluno.nome,
      apelido: aluno.apelido,
      usarApelido: aluno.usarApelido,
      cpf: aluno.cpf,
      contato: aluno.contato ?? '',
      contatoEmergencia: aluno.contatoEmergencia ?? '',
      email: aluno.email,
      nascimento: aluno.nascimento,
      tipoSanguineo: aluno.tipoSanguineo,
      faixa: aluno.faixa,
      grau: aluno.grau,
      idFicha: '${aluno.idFicha ?? ""}',
      idTurma: aluno.idTurma,
      nomeResponsavel: responsavel?.nome ?? '',
      cpfResponsavel: responsavel?.cpf ?? '',
      contatoResponsavel: responsavel?.contato ?? '',
      emailResponsavel: responsavel?.email ?? '',
    );
  }

  void updateNome(String value) {
    state = state.copyWith(nome: value, dirty: true);
  }

  void updateApelido(String? value) {
    final ap = (value != null && value.trim().isNotEmpty) ? value.trim() : null;
    final novoUsarReferencia = ap == null
        ? false
        : ((state.apelido == null || state.apelido!.isEmpty)
              ? true
              : state.usarApelido);
    state = state.copyWith(
      apelido: ap,
      usarApelido: novoUsarReferencia,
      dirty: true,
    );
  }

  void updateUsarApelidoComoReferencia(bool value) {
    state = state.copyWith(usarApelido: value, dirty: true);
  }

  void updateCPF(String value) {
    state = state.copyWith(cpf: value, dirty: true);
  }

  void updateContato(String value) {
    state = state.copyWith(contato: value, dirty: true);
  }

  void updateContatoEmergencia(String value) {
    state = state.copyWith(contatoEmergencia: value, dirty: true);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, dirty: true);
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

  void updateIdFicha(String value) {
    state = state.copyWith(idFicha: value, dirty: true);
  }

  void updateIdTurma(int? value) {
    state = state.copyWith(idTurma: value, dirty: true);
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

  void updateEmailResponsavel(String value) {
    state = state.copyWith(emailResponsavel: value, dirty: true);
  }
}
