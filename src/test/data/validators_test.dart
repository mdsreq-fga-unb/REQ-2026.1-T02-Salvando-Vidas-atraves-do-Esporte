import 'package:flutter_test/flutter_test.dart';
import 'package:salvando_vidas/data/validators.dart';

void main() {
  group('Validators Tests', () {
    test('eEmail', () {
      expect(eEmail('teste@exemplo.com'), isTrue);
      expect(eEmail('teste.nome@sub.exemplo.com.br'), isTrue);
      expect(eEmail('invalido@com'), isFalse);
      expect(eEmail('invalido.com'), isFalse);
      expect(eEmail(''), isFalse);
    });

    test('eTelefone', () {
      expect(eTelefone('11987654321'), isTrue); // 11 digitos
      expect(eTelefone('1187654321'), isTrue);  // 10 digitos
      expect(eTelefone('123'), isFalse);
      expect(eTelefone('abcdefghij'), isFalse);
      expect(eTelefone(''), isFalse);
    });

    test('eCPF', () {
      // CPF válido (verificador real)
      expect(eCPF('52998224725'), isTrue);

      // Tamanho incorreto
      expect(eCPF('123'), isFalse);
      expect(eCPF('abcdefghijk'), isFalse);

      // Todos dígitos iguais
      expect(eCPF('00000000000'), isFalse);
      expect(eCPF('11111111111'), isFalse);
      expect(eCPF('22222222222'), isFalse);
      expect(eCPF('33333333333'), isFalse);
      expect(eCPF('44444444444'), isFalse);
      expect(eCPF('55555555555'), isFalse);
      expect(eCPF('66666666666'), isFalse);
      expect(eCPF('77777777777'), isFalse);
      expect(eCPF('88888888888'), isFalse);
      expect(eCPF('99999999999'), isFalse);
      expect(eCPF('01234567890'), isFalse);

      // Dígito verificador incorreto
      expect(eCPF('52998224735'), isFalse);
    });
  });
}
