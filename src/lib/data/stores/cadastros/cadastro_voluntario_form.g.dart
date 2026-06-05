// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_voluntario_form.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CadastroVoluntarioFormStore on _CadastroVoluntarioFormStore, Store {
  Computed<bool>? _$podeCadastrarComputed;

  @override
  bool get podeCadastrar => (_$podeCadastrarComputed ??= Computed<bool>(
    () => super.podeCadastrar,
    name: '_CadastroVoluntarioFormStore.podeCadastrar',
  )).value;

  late final _$nomeAtom = Atom(
    name: '_CadastroVoluntarioFormStore.nome',
    context: context,
  );

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$emailAtom = Atom(
    name: '_CadastroVoluntarioFormStore.email',
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

  late final _$telefoneAtom = Atom(
    name: '_CadastroVoluntarioFormStore.telefone',
    context: context,
  );

  @override
  String get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  late final _$senhaAtom = Atom(
    name: '_CadastroVoluntarioFormStore.senha',
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

  late final _$cpfAtom = Atom(
    name: '_CadastroVoluntarioFormStore.cpf',
    context: context,
  );

  @override
  String get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  late final _$_CadastroVoluntarioFormStoreActionController = ActionController(
    name: '_CadastroVoluntarioFormStore',
    context: context,
  );

  @override
  void validaNome(String nome) {
    final _$actionInfo = _$_CadastroVoluntarioFormStoreActionController
        .startAction(name: '_CadastroVoluntarioFormStore.validaNome');
    try {
      return super.validaNome(nome);
    } finally {
      _$_CadastroVoluntarioFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validaEmail(String email) {
    final _$actionInfo = _$_CadastroVoluntarioFormStoreActionController
        .startAction(name: '_CadastroVoluntarioFormStore.validaEmail');
    try {
      return super.validaEmail(email);
    } finally {
      _$_CadastroVoluntarioFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validaTelefone(String telefone) {
    final _$actionInfo = _$_CadastroVoluntarioFormStoreActionController
        .startAction(name: '_CadastroVoluntarioFormStore.validaTelefone');
    try {
      return super.validaTelefone(telefone);
    } finally {
      _$_CadastroVoluntarioFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validaSenha(String senha) {
    final _$actionInfo = _$_CadastroVoluntarioFormStoreActionController
        .startAction(name: '_CadastroVoluntarioFormStore.validaSenha');
    try {
      return super.validaSenha(senha);
    } finally {
      _$_CadastroVoluntarioFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validaCPF(String cpf) {
    final _$actionInfo = _$_CadastroVoluntarioFormStoreActionController
        .startAction(name: '_CadastroVoluntarioFormStore.validaCPF');
    try {
      return super.validaCPF(cpf);
    } finally {
      _$_CadastroVoluntarioFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nome: ${nome},
email: ${email},
telefone: ${telefone},
senha: ${senha},
cpf: ${cpf},
podeCadastrar: ${podeCadastrar}
    ''';
  }
}

mixin _$CadastroVoluntarioFormErrorState
    on _CadastroVoluntarioFormErrorState, Store {
  Computed<bool>? _$temErrosComputed;

  @override
  bool get temErros => (_$temErrosComputed ??= Computed<bool>(
    () => super.temErros,
    name: '_CadastroVoluntarioFormErrorState.temErros',
  )).value;

  late final _$nomeAtom = Atom(
    name: '_CadastroVoluntarioFormErrorState.nome',
    context: context,
  );

  @override
  String? get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String? value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$emailAtom = Atom(
    name: '_CadastroVoluntarioFormErrorState.email',
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

  late final _$telefoneAtom = Atom(
    name: '_CadastroVoluntarioFormErrorState.telefone',
    context: context,
  );

  @override
  String? get telefone {
    _$telefoneAtom.reportRead();
    return super.telefone;
  }

  @override
  set telefone(String? value) {
    _$telefoneAtom.reportWrite(value, super.telefone, () {
      super.telefone = value;
    });
  }

  late final _$senhaAtom = Atom(
    name: '_CadastroVoluntarioFormErrorState.senha',
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

  late final _$cpfAtom = Atom(
    name: '_CadastroVoluntarioFormErrorState.cpf',
    context: context,
  );

  @override
  String? get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String? value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  @override
  String toString() {
    return '''
nome: ${nome},
email: ${email},
telefone: ${telefone},
senha: ${senha},
cpf: ${cpf},
temErros: ${temErros}
    ''';
  }
}
