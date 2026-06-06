import 'package:mobx/mobx.dart';
import 'package:salvando_vidas/data/validators.dart';
import 'package:salvando_vidas/domain/local_user/local_user.dart';

part 'cadastro_voluntario_form.g.dart';

// ignore: library_private_types_in_public_api
class CadastroVoluntarioFormStore = _CadastroVoluntarioFormStore
    with _$CadastroVoluntarioFormStore;

abstract class _CadastroVoluntarioFormStore with Store {
  final CadastroVoluntarioFormErrorState error =
      CadastroVoluntarioFormErrorState();

  @observable
  String nome = '';

  @observable
  String email = '';

  @observable
  String telefone = '';

  @observable
  String senha = '';

  @observable
  String cpf = '';

  LocalUser get voluntario => LocalUser(
    role: Role.voluntario,
    nome: nome,
    telefone: telefone,
    cpf: cpf,
    email: email,
    senha: senha,
  );

  @action
  void validaNome(String nome) {
    error.nome = nome.isNotEmpty ? null : 'Não pode estar em branco';
  }

  @action
  void validaEmail(String email) {
    error.email = eEmail(email) ? null : 'Não é um email válido';
  }

  @action
  void validaTelefone(String telefone) {
    error.telefone = eTelefone(telefone) ? null : 'Não é um telefone válido';
  }

  @action
  void validaSenha(String senha) {
    error.senha = senha.isNotEmpty ? null : 'Não pode estar em branco';
  }

  @action
  void validaCPF(String cpf) {
    error.cpf = eCPF(cpf) ? null : 'Não é um CPF válido';
  }

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => nome, validaNome),
      reaction((_) => email, validaEmail),
      reaction((_) => telefone, validaTelefone),
      reaction((_) => senha, validaSenha),
      reaction((_) => cpf, validaCPF),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @computed
  bool get podeCadastrar => !error.temErros;
}

// ignore: library_private_types_in_public_api
class CadastroVoluntarioFormErrorState = _CadastroVoluntarioFormErrorState
    with _$CadastroVoluntarioFormErrorState;

abstract class _CadastroVoluntarioFormErrorState with Store {
  @observable
  String? nome = '';

  @observable
  String? email = '';

  @observable
  String? telefone = '';

  @observable
  String? senha = '';

  @observable
  String? cpf = '';

  @computed
  bool get temErros =>
      nome != null ||
      email != null ||
      telefone != null ||
      senha != null ||
      cpf != null;
}
