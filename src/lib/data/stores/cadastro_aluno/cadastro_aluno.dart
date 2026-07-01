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
  final String? apelido;
  final bool usarApelido;
  final String cpf;
  final String contato;
  final String contatoEmergencia; // NOVA VARIÁVEL
  final String email;
  final DateTime? nascimento;
  final TipoSanguineo? tipoSanguineo;
  final Faixa? faixa;
  final int grau;
  final String idFicha;
  final bool dirty;

  final bool pMedica1;
  final bool pMedica2;
  final bool pMedica3;
  final bool pMedica4;
  final bool pMedica5;

  final String? observacaoMedica;

  final String nomeResponsavel;
  final String cpfResponsavel;
  final String contatoResponsavel;
  final String emailResponsavel;

  CadastroAlunoState({
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
    this.pMedica1 = false,
    this.pMedica2 = false,
    this.pMedica3 = false,
    this.pMedica4 = false,
    this.pMedica5 = false,
    this.observacaoMedica = '',
    this.nomeResponsavel = '',
    this.cpfResponsavel = '',
    this.contatoResponsavel = '',
    this.emailResponsavel = '',
    this.dirty = false,
  });

  String? get nomeError => null;

  String? get nomeResponsavelError => null;

  String? get cpfError {
    if (cpf.isEmpty) return null;
    return eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  String? get cpfResponsavelError {
    if (cpfResponsavel.isEmpty) return null;
    return eCPF(cpfResponsavel) ? null : 'Não é um CPF válido';
  }

  String? get contatoError {
    if (contato.isEmpty) return null;
    return eTelefone(contato) ? null : 'Não é um telefone válido';
  }

  String? get contatoEmergenciaError {
    if (contatoEmergencia.isEmpty) return null;
    return eTelefone(contatoEmergencia) ? null : 'Não é um telefone válido';
  }

  String? get contatoResponsavelError {
    if (contatoResponsavel.isEmpty) return null;
    return eTelefone(contatoResponsavel) ? null : 'Não é um telefone válido';
  }

  String? get emailError {
    if (email.isEmpty) return null;
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get emailResponsavelError {
    if (emailResponsavel.isEmpty) return null;
    return eEmail(emailResponsavel) ? null : 'Não é um email válido';
  }

  String? get nascimentoError => null;

  String? get tipoSanguineoError => null;

  String? get faixaError => null;

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
      faixaError != null;

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
    return nomeResponsavel.isNotEmpty &&
        cpfResponsavel.isNotEmpty &&
        contatoResponsavel.isNotEmpty &&
        nomeResponsavelError == null &&
        cpfResponsavelError == null &&
        contatoResponsavelError == null;
  }

  Aluno get aluno => Aluno(
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
    ativo: true,
    federado: false,
    dataEntrada: DateTime.now(),
    idFicha: int.tryParse(idFicha),
    pMedica1: pMedica1,
    pMedica2: pMedica2,
    pMedica3: pMedica3,
    pMedica4: pMedica4,
    pMedica5: pMedica5,
    observacaoMedica: observacaoMedica,
  );

  Responsavel get responsavel => Responsavel(
    nome: nomeResponsavel,
    cpf: cpfResponsavel,
    contato: contatoResponsavel,
    email: emailResponsavel,
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

  void updateUsarApelido(bool value) {
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

  void updatePMedica1(bool value) {
    state = state.copyWith(pMedica1: value);
  }

  void updatePMedica2(bool value) {
    state = state.copyWith(pMedica2: value);
  }

  void updatePMedica3(bool value) {
    state = state.copyWith(pMedica3: value);
  }

  void updatePMedica4(bool value) {
    state = state.copyWith(pMedica4: value);
  }

  void updatePMedica5(bool value) {
    state = state.copyWith(pMedica5: value);
  }

  void updateObservacaoMedica(String? value) {
    state = state.copyWith(observacaoMedica: value);
  }

  void reset() {
    state = CadastroAlunoState();
  }
}
