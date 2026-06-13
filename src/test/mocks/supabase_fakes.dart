import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef Response = List<Map<String, dynamic>>;

class FakeCountBuilder<T> extends Fake implements ResponsePostgrestBuilder<PostgrestResponse<T>, T, T> {
  final T _mockData;

  FakeCountBuilder(this._mockData);

  @override
  Future<R> then<R>(
    FutureOr<R> Function(PostgrestResponse<T> value) onValue, {
    Function? onError,
  }) {
    final response = PostgrestResponse<T>(
      data: _mockData,
      count: (_mockData as List).length,
    );
    return Future.value(response).then(onValue, onError: onError);
  }
}

class FakeFilterBuilder<T> extends Fake implements PostgrestFilterBuilder<T> {
  final T _mockData;

  FakeFilterBuilder(this._mockData);

  @override
  PostgrestFilterBuilder<T> eq(String column, Object value) => this;

  @override
  PostgrestTransformBuilder<PostgrestList> select([String columns = '*']) => this as dynamic;

  @override
  ResponsePostgrestBuilder<PostgrestResponse<T>, T, T> count([CountOption count = CountOption.exact]) {
    return FakeCountBuilder<T>(_mockData);
  }

  @override
  Future<R> then<R>(
    FutureOr<R> Function(T value) onValue, {
    Function? onError,
  }) {
    return Future.value(_mockData).then(onValue, onError: onError);
  }
}

// ... Daqui para baixo, o seu FakeQueryBuilder continua exatamente igual!
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
