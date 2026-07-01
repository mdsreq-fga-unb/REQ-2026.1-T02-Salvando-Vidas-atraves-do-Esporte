import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salvando_vidas/data/stores/gestao_kimonos/gestao_kimonos_store.dart';
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
  final List<Estoque> estoqueList;

  RegistroKimonosState({
    this.tamanhoDoacao,
    this.corDoacao,
    this.doador = '',
    this.qtdDoada = '',
    this.kimonoPerdido,
    this.motivo = '',
    this.qtdPerdida = '',
    this.estoqueList = const [],
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
    if (qtd == null || qtd <= 0) {
      return "Deve informar o número de kimonos doados";
    }
    return null;
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
    if (qtd == null || qtd <= 0) {
      return "Deve informar a quantidade de kimonos perdidos";
    }
    if (kimonoPerdido != null) {
      if (qtd > kimonoPerdido!.quantidadeDisponivel) {
        return "A quantidade excede o estoque disponível (${kimonoPerdido!.quantidadeDisponivel})";
      }
    }
    return null;
  }

  bool get doacaoValida =>
      tamanhoDoacaoError == null &&
      corDoacaoError == null &&
      doadorError == null &&
      qtdDoadaError == null;

  bool perdaValida([List<Estoque>? estoque]) {
    final list = estoque ?? estoqueList;
    final disponivel =
        list
            .firstWhereOrNull((e) => e == kimonoPerdido)
            ?.quantidadeDisponivel ??
        kimonoPerdido?.quantidadeDisponivel ??
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
    final estoque =
        ref.read(gestaoKimonosStoreProvider).value?.estoque ?? [];
    return RegistroKimonosState(estoqueList: estoque);
  }

  List<Estoque> get _currentEstoque =>
      ref.read(gestaoKimonosStoreProvider).value?.estoque ??
      state.estoqueList;

  void syncEstoque(List<Estoque> estoque) {
    if (state.estoqueList != estoque) {
      state = state.copyWith(estoqueList: estoque);
    }
  }

  void updateTamanhoDoacao(TamanhoKimono? tamanho) {
    state = state.copyWith(
      tamanhoDoacao: tamanho,
      estoqueList: _currentEstoque,
    );
  }

  void updateCorDoacao(CorKimono? cor) {
    state = state.copyWith(corDoacao: cor, estoqueList: _currentEstoque);
  }

  void updateDoador(String doador) {
    state = state.copyWith(doador: doador, estoqueList: _currentEstoque);
  }

  void updateQtdDoada(String qtd) {
    state = state.copyWith(qtdDoada: qtd, estoqueList: _currentEstoque);
  }

  void updateKimonoPerdido(Estoque? kimono) {
    state = state.copyWith(kimonoPerdido: kimono, estoqueList: _currentEstoque);
  }

  void updateMotivo(String motivo) {
    state = state.copyWith(motivo: motivo, estoqueList: _currentEstoque);
  }

  void updateQtdPerdida(String qtd) {
    state = state.copyWith(qtdPerdida: qtd, estoqueList: _currentEstoque);
  }

  void reset() {
    state = RegistroKimonosState(estoqueList: _currentEstoque);
  }
}
