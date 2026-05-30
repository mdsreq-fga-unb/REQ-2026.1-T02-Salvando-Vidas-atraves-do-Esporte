bool eEmail(String email) {
  final exp = RegExp(r"^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$");
  return exp.hasMatch(email);
}

bool eTelefone(String senha) {
  final exp = RegExp(r"^[\d]{10,11}$");
  return exp.hasMatch(senha);
}

bool eCPF(String cpf) {
  final exp = RegExp(r"^[\d]{11}$");
  return exp.hasMatch(cpf);
}
