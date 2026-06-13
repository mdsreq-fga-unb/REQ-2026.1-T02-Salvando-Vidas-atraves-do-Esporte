import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef Response = List<Map<String, dynamic>>;

class FakeFilterBuilder<T> extends Fake implements PostgrestFilterBuilder<T> {
  final T _mockData;

  FakeFilterBuilder(this._mockData);

  @override
  PostgrestFilterBuilder<T> eq(String column, Object value) => this;

  // Se no futuro a gente usar filtros como .neq, .gt, ou .lt no projeto, 
  // basta adicioná-los aqui seguindo o mesmo padrão do .eq!

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) {
    return Future.value(_mockData).then(onValue, onError: onError);
  }
}

class FakeQueryBuilder extends Fake implements SupabaseQueryBuilder {
  final Response _mockData;

  FakeQueryBuilder(this._mockData);

  @override
  PostgrestFilterBuilder<Response> select([String columns = '*']) {
    return FakeFilterBuilder(_mockData);
  }

  @override
  PostgrestFilterBuilder<Response> insert(
    Object values, {
    bool defaultToNull = true,
  }) {
    return FakeFilterBuilder(_mockData);
  }

  // NOVO: Adicionado para suportar o cadastrarResponsavel
  @override
  PostgrestFilterBuilder<Response> upsert(
    Object values, {
    String? onConflict,
    bool ignoreDuplicates = false,
    bool defaultToNull = true,
  }) {
    return FakeFilterBuilder(_mockData);
  }

  // NOVO: Adicionado para suportar o atualizaAluno e atualizaResponsavel
  @override
  PostgrestFilterBuilder<Response> update(
    Map<dynamic, dynamic> values,
  ) {
    return FakeFilterBuilder(_mockData);
  }

  // NOVO: Adicionado para suportar o deletaAluno e deletaResponsavel
  @override
  PostgrestFilterBuilder<Response> delete() {
    return FakeFilterBuilder(_mockData);
  }
}
