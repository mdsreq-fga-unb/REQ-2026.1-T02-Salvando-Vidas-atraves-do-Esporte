import 'package:salvando_vidas/main_imports.dart';

bool eEmail(String email) {
  final exp = RegExp(r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$");
  return exp.hasMatch(email);
}

bool eTelefone(String telefone) {
  final exp = RegExp(r"^[\d]{10,11}$");
  return exp.hasMatch(telefone);
}

bool eCPF(String cpf) {
  final exp = RegExp(r"^[\d]{11}$");
  if (!exp.hasMatch(cpf)) return false;

  switch (cpf) {
    case "00000000000":
    case "11111111111":
    case "22222222222":
    case "33333333333":
    case "44444444444":
    case "55555555555":
    case "66666666666":
    case "77777777777":
    case "88888888888":
    case "99999999999":
    case "01234567890":
      return false;
  }

  List<int> digitos = [];
  for (final digito in cpf.characters) {
    digitos.add(int.parse(digito));
  }

  int ver1 = int.parse(cpf[9]);
  int ver2 = int.parse(cpf[10]);
  int verC = 0;

  for (var i = 0; i < 9; i++) {
    verC += digitos[i] * (10 - i);
  }

  verC %= 11;

  if (((verC == 0 || verC == 1) && ver1 != 0) || ((11 - verC) != ver1)) {
    return false;
  }

  verC = 0;

  for (var i = 0; i < 10; i++) {
    verC += digitos[i] * (11 - i);
  }

  verC %= 11;

  if (((verC == 0 || verC == 1) && ver2 != 0) || ((11 - verC) != ver2)) {
    return false;
  }

  return true;
}
