import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';

part 'login_form.g.dart';

class LoginFormState {
  final String email;
  final String senha;
  final bool dirty;

  LoginFormState({this.email = '', this.senha = '', this.dirty = false});

  String? get emailError {
    if (email.isEmpty) {
      return dirty ? 'Não pode estar em branco' : null;
    }
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get senhaError {
    if (senha.isEmpty) {
      return dirty ? 'Não pode estar em branco' : null;
    }
    return null;
  }

  bool get temErros => emailError != null || senhaError != null;
  bool get canLogin => email.isNotEmpty && eEmail(email) && senha.isNotEmpty;

  LoginFormState copyWith({String? email, String? senha, bool? dirty}) {
    return LoginFormState(
      email: email ?? this.email,
      senha: senha ?? this.senha,
      dirty: dirty ?? this.dirty,
    );
  }
}

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() {
    return LoginFormState();
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value);
  }

  void updateSenha(String value) {
    state = state.copyWith(senha: value);
  }

  void validateForm() {
    state = state.copyWith(dirty: true);
  }
}
