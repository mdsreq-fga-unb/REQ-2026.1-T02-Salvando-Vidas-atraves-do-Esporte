// test/mocks/supabase_fakes.dart
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef Response = List<Map<String, dynamic>>;

class FakeFilterBuilder<T> extends Fake implements PostgrestFilterBuilder<T> {
  final T _mockData;

  FakeFilterBuilder(this._mockData);

  @override
  PostgrestFilterBuilder<T> eq(String column, Object value) => this;

  // You can add more overrides here as your app grows!
  // @override
  // PostgrestFilterBuilder<T> neq(String column, Object value) => this;

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

  // If you later need to mock an insert, you add it here:
  @override
  PostgrestFilterBuilder<Response> insert(
    Object values, {
    bool defaultToNull = true,
  }) {
    return FakeFilterBuilder(_mockData);
  }
}
