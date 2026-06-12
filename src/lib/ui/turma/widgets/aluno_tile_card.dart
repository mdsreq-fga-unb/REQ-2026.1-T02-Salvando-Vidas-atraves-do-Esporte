import 'package:flutter/material.dart';

class AlunoTileWidget extends StatelessWidget {
  final String nome;

  const AlunoTileWidget({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Color(0xFFD9D9D9)),
      title: Text(nome, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
