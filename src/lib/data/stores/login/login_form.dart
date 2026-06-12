import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/validators.dart';

part 'login_form.g.dart';

class LoginFormState {
  final String email;
  final String senha;
  final bool dirty;

  LoginFormState({this.email = '', this.senha = '', this.dirty = false});

  String? get emailError {
    if (!dirty && email.isEmpty) return null;
    return eEmail(email) ? null : 'Não é um email válido';
  }

  String? get senhaError {
    if (!dirty && senha.isEmpty) return null;
    return senha.isNotEmpty ? null : 'Não pode estar em branco';
  }

  bool get temErros => emailError != null || senhaError != null;
  bool get canLogin => email.isNotEmpty && senha.isNotEmpty && !temErros;

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

  // Substitui as @actions
  void updateEmail(String value) {
    state = state.copyWith(email: value, dirty: true);
  }

  void updateSenha(String value) {
    state = state.copyWith(senha: value, dirty: true);
  }
}
