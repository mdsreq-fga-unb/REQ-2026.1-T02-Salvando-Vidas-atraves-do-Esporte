// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_form.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginFormStore on _LoginFormStore, Store {
  Computed<bool>? _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??= Computed<bool>(
    () => super.canLogin,
    name: '_LoginFormStore.canLogin',
  )).value;

  late final _$emailAtom = Atom(
    name: '_LoginFormStore.email',
    context: context,
  );

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$senhaAtom = Atom(
    name: '_LoginFormStore.senha',
    context: context,
  );

  @override
  String get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  late final _$_LoginFormStoreActionController = ActionController(
    name: '_LoginFormStore',
    context: context,
  );

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
      name: '_LoginFormStore.validateEmail',
    );
    try {
      return super.validateEmail(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_LoginFormStoreActionController.startAction(
      name: '_LoginFormStore.validatePassword',
    );
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
senha: ${senha},
canLogin: ${canLogin}
    ''';
  }
}

mixin _$LoginFormErrorState on _LoginFormErrorState, Store {
  Computed<bool>? _$temErrosComputed;

  @override
  bool get temErros => (_$temErrosComputed ??= Computed<bool>(
    () => super.temErros,
    name: '_LoginFormErrorState.temErros',
  )).value;

  late final _$emailAtom = Atom(
    name: '_LoginFormErrorState.email',
    context: context,
  );

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$senhaAtom = Atom(
    name: '_LoginFormErrorState.senha',
    context: context,
  );

  @override
  String? get senha {
    _$senhaAtom.reportRead();
    return super.senha;
  }

  @override
  set senha(String? value) {
    _$senhaAtom.reportWrite(value, super.senha, () {
      super.senha = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
senha: ${senha},
temErros: ${temErros}
    ''';
  }
}
