import 'package:flutter/material.dart';

class AlunoTileWidget extends StatelessWidget {
  final String nome;

  const AlunoTileWidget({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFD8DDE6), // Azul/Cinza clarinho padrão do projeto
        child: Icon(Icons.person, color: Color(0xFF08216F), size: 20), // Ícone adicionado
      ),
      title: Text(
        nome, 
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF08216F), // Texto no Azul Principal
        ),
      ),
      shape: const Border(
        bottom: BorderSide(color: Color(0xFFE6E6E6), width: 1), // Linha divisória suave entre os alunos
      ),
    );
  }
}