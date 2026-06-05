import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
export 'package:supabase_flutter/supabase_flutter.dart';

typedef Response = List<Map<String, dynamic>>;

sealed class Result<S> {}

class Success<S> extends Result<S> {
  final S value;
  Success(this.value);
}

class Failure<S> extends Result<S> {
  final String message;
  final Object? error;

  Failure(this.message, [this.error]);
}

extension FutureTimeout<T> on Future<T> {
  Future<T> withDefaultTimeout({int seconds = 5}) {
    return timeout(
      Duration(seconds: seconds),
      onTimeout: () {
        throw TimeoutException('A operação demorou demais para responder.');
      },
    );
  }
}

Future<Result<T>> safeSupabaseCall<T>(Future<T> Function() action) async {
  try {
    final result = await action().withDefaultTimeout();
    return Success(result);
  } on TimeoutException {
    return Failure('A conexão expirou.');
  } on AuthApiException {
    return Failure('Credenciais incorretas.');
  } catch (e) {
    return Failure('Ocorreu um erro inesperado.', e);
  }
}
