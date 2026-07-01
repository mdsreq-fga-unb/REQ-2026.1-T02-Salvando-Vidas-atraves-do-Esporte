import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/domain/kimono/kimono.dart';

import 'package:collection/collection.dart';

part 'registro_kimonos_store.g.dart';
part 'registro_kimonos_store.mapper.dart';

@MappableClass()
class RegistroKimonosState with RegistroKimonosStateMappable {
  final TamanhoKimono? tamanhoDoacao;
  final CorKimono? corDoacao;
  final String doador;
  final String qtdDoada;

  final Estoque? kimonoPerdido;
  final String motivo;
  final String qtdPerdida;

  RegistroKimonosState({
    this.tamanhoDoacao,
    this.corDoacao,
    this.doador = '',
    this.qtdDoada = '',
    this.kimonoPerdido,
    this.motivo = '',
    this.qtdPerdida = '',
  });

  String? get tamanhoDoacaoError {
    return tamanhoDoacao != null ? null : "Deve selecionar o tamanho do kimono";
  }

  String? get corDoacaoError {
    return corDoacao != null ? null : "Deve selecionar a cor do kimono";
  }

  String? get doadorError {
    return doador.isNotEmpty ? null : "Deve informar o nome do doador";
  }

  String? get qtdDoadaError {
    final qtd = int.tryParse(qtdDoada);
    return qtd != null && qtd > 0
        ? null
        : "Deve informar o número de kimonos doados";
  }

  String? get kimonoPerdidoError {
    return kimonoPerdido != null
        ? null
        : "Deve selecionar um kimono para registrar a perda";
  }

  String? get motivoError {
    return motivo.isNotEmpty ? null : "Deve informar o motivo da perda";
  }

  String? get qtdPerdidaError {
    final qtd = int.tryParse(qtdPerdida);
    return qtd != null && qtd > 0
        ? null
        : "Deve informar a quantidade de kimonos perdidos";
  }

  bool get doacaoValida =>
      tamanhoDoacaoError == null &&
      corDoacaoError == null &&
      doadorError == null &&
      qtdDoadaError == null;

  bool perdaValida(List<Estoque>? estoque) {
    final disponivel =
        estoque
            ?.firstWhereOrNull((e) => e == kimonoPerdido)
            ?.quantidadeDisponivel ??
        0;

    if ((int.tryParse(qtdPerdida) ?? 0) > disponivel) return false;

    return kimonoPerdidoError == null &&
        motivoError == null &&
        qtdPerdidaError == null;
  }

  Doacao get doacao => Doacao(
    doador: doador,
    cor: corDoacao!,
    tamanho: tamanhoDoacao!,
    quantidade: int.parse(qtdDoada),
    data: DateTime.now(),
  );

  Perda get perda => Perda(
    cor: kimonoPerdido!.cor,
    tamanho: kimonoPerdido!.tamanho,
    quantidade: int.parse(qtdPerdida),
    motivo: motivo,
    data: DateTime.now(),
  );
}

@Riverpod()
class RegistroKimonosStore extends _$RegistroKimonosStore {
  @override
  RegistroKimonosState build() {
    return RegistroKimonosState();
  }

  void updateTamanhoDoacao(TamanhoKimono? tamanho) {
    state = state.copyWith(tamanhoDoacao: tamanho);
  }

  void updateCorDoacao(CorKimono? cor) {
    state = state.copyWith(corDoacao: cor);
  }

  void updateDoador(String doador) {
    state = state.copyWith(doador: doador);
  }

  void updateQtdDoada(String qtd) {
    state = state.copyWith(qtdDoada: qtd);
  }

  void updateKimonoPerdido(Estoque? kimono) {
    state = state.copyWith(kimonoPerdido: kimono);
  }

  void updateMotivo(String motivo) {
    state = state.copyWith(motivo: motivo);
  }

  void updateQtdPerdida(String qtd) {
    state = state.copyWith(qtdPerdida: qtd);
  }

  void reset() {
    state = RegistroKimonosState();
  }
}
