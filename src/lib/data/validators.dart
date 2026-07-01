import 'package:salvando_vidas/main_imports.dart';

bool eEmail(String email) {
  final clean = email.trim();
  final exp = RegExp(r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$");
  return exp.hasMatch(clean);
}

bool eTelefone(String telefone) {
  final clean = telefone.replaceAll(RegExp(r'[^0-9]'), '');
  return clean.length >= 10 && clean.length <= 11;
}

bool eCPF(String cpf) {
  final clean = cpf.replaceAll(RegExp(r'[^0-9]'), '');
  if (clean.length != 11) return false;

  if (RegExp(r'^(\d)\1{10}$').hasMatch(clean) || clean == '01234567890') {
    return false;
  }

  final digitos = clean.split('').map(int.parse).toList();

  var soma1 = 0;
  for (var i = 0; i < 9; i++) {
    soma1 += digitos[i] * (10 - i);
  }
  final resto1 = soma1 % 11;
  final ver1 = resto1 < 2 ? 0 : 11 - resto1;
  if (digitos[9] != ver1) return false;

  var soma2 = 0;
  for (var i = 0; i < 10; i++) {
    soma2 += digitos[i] * (11 - i);
  }
  final resto2 = soma2 % 11;
  final ver2 = resto2 < 2 ? 0 : 11 - resto2;
  return digitos[10] == ver2;
}
