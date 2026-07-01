import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/supabase_call.dart';

void main() {
  group('Supabase Call & Timeout Tests', () {
    test('runSupabaseCall - sucesso', () async {
      final res = await runSupabaseCall(() async => 'ok');
      expect(res, 'ok');
    });

    test('runSupabaseCall - AppApiException e timeout', () async {
      expect(
        () => runSupabaseCall(() {
          return Future.delayed(const Duration(milliseconds: 1500), () => 'demorou').withDefaultTimeout(seconds: 1);
        }),
        throwsA(isA<AppApiException>()),
      );
    });

    test('runSupabaseCall - AuthApiException', () async {
      expect(
        () => runSupabaseCall(() async {
          throw AuthApiException('erro auth');
        }),
        throwsA(predicate((e) => e is AppApiException && e.message == 'Credenciais incorretas.')),
      );
    });

    test('runSupabaseCall - PostgrestException 23505', () async {
      expect(
        () => runSupabaseCall(() async {
          throw const PostgrestException(message: 'duplicado', code: '23505');
        }),
        throwsA(predicate((e) => e is AppApiException && e.message.contains('valor único'))),
      );
    });

    test('runSupabaseCall - PostgrestException outro codigo', () async {
      expect(
        () => runSupabaseCall(() async {
          throw const PostgrestException(message: 'erro gen banc', code: '99999');
        }),
        throwsA(predicate((e) => e is AppApiException && e.message.contains('erro inesperado ocorreu'))),
      );
    });

    test('runSupabaseCall - Exception generica', () async {
      expect(
        () => runSupabaseCall(() async {
          throw Exception('erro gen');
        }),
        throwsA(predicate((e) => e is AppApiException && e.message == 'Ocorreu um erro inesperado.')),
      );
    });

    test('AppApiException toString', () {
      final exc = AppApiException('msg erro');
      expect(exc.toString(), 'msg erro');
    });
  });
}
