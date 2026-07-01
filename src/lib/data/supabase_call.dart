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
  Future<T> withDefaultTimeout({int seconds = 3}) {
    return timeout(
      Duration(seconds: seconds),
      onTimeout: () {
        throw AppApiException('A operação demorou demais para responder.');
      },
    );
  }
}

// Em vez de retornar Result<T>, retornamos T diretamente e lançamos exceções amigáveis
Future<T> runSupabaseCall<T>(
  Future<T> Function() action, {
  int timeout = 3,
}) async {
  try {
    return await action().withDefaultTimeout(seconds: timeout);
  } on AppApiException {
    rethrow;
  } on AuthApiException catch (e) {
    throw AppApiException('Credenciais incorretas.', e);
  } on PostgrestException catch (e) {
    switch (e.code) {
      case "23505":
        throw AppApiException(
          'Algum campo com valor único já tem o valor registrado (CPF ou email)',
          e,
        );
      default:
        throw AppApiException(
          'Algum erro inesperado ocorreu ao tentar se comunicar com o banco de dados',
          e,
        );
    }
  } catch (e) {
    throw AppApiException('Ocorreu um erro inesperado.', e);
  }
}
