import 'package:mobx/mobx.dart';
import 'package:salvando_vidas/data/validators.dart';

part 'login_form.g.dart';

// ignore: library_private_types_in_public_api
class LoginFormStore = _LoginFormStore with _$LoginFormStore;

abstract class _LoginFormStore with Store {
  final LoginFormErrorState error = LoginFormErrorState();

  @observable
  String email = '';

  @observable
  String senha = '';

  @computed
  bool get canLogin => !error.temErros;

  @action
  void validateEmail(String value) {
    error.email = eEmail(value) ? null : 'Não é um email válido';
  }

  @action
  void validatePassword(String value) {
    error.senha = value.isNotEmpty ? null : 'Não pode estar em branco';
  }

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => senha, validatePassword),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}

// ignore: library_private_types_in_public_api
class LoginFormErrorState = _LoginFormErrorState with _$LoginFormErrorState;

abstract class _LoginFormErrorState with Store {
  @observable
  String? email;

  @observable
  String? senha;

  @computed
  bool get temErros => email != null || senha != null;
}
