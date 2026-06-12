import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
export 'package:supabase_flutter/supabase_flutter.dart';

// Uma exceção customizada para encapsular nossos erros
class AppApiException implements Exception {
  final String message;
  final Object? error;

  AppApiException(this.message, [this.error]);

  @override
  String toString() => message;
}

extension FutureTimeout<T> on Future<T> {
  Future<T> withDefaultTimeout({int seconds = 5}) {
    return timeout(
      Duration(seconds: seconds),
      onTimeout: () {
        throw AppApiException('A operação demorou demais para responder.');
      },
    );
  }
}

// Em vez de retornar Result<T>, retornamos T diretamente e lançamos exceções amigáveis
Future<T> runSupabaseCall<T>(Future<T> Function() action) async {
  try {
    return await action().withDefaultTimeout();
  } on AppApiException {
    rethrow;
  } on AuthApiException catch (e) {
    throw AppApiException('Credenciais incorretas.', e);
  } catch (e) {
    throw AppApiException('Ocorreu um erro inesperado.', e);
  }
}
