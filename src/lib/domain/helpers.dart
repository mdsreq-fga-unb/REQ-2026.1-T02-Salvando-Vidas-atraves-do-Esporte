import 'package:dart_mappable/dart_mappable.dart';

typedef Data = Map<String, dynamic>;
typedef Response = List<Data>;

Data obterDiff(Data original, Data atualizado) {
  final Data diff = {};

  atualizado.forEach((key, value) {
    if (original[key] != value) {
      diff[key] = value;
    }
  });

  return diff;
}

class HookData extends MappingHook {
  const HookData();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return DateTime.tryParse(value);
    }

    return null;
  }

  @override
  Object? beforeEncode(Object? value) {
    if (value is DateTime) {
      final ano = value.year.toString().padLeft(4, '0');
      final mes = value.month.toString().padLeft(2, '0');
      final dia = value.day.toString().padLeft(2, '0');

      return '$ano-$mes-$dia';
    }

    return null;
  }
}

class HookHorario extends MappingHook {
  const HookHorario();

  @override
  Object? beforeDecode(Object? value) {
    if (value is String) {
      return DateTime.tryParse('1970-01-01T$value');
    }

    return null;
  }

  @override
  Object? beforeEncode(Object? value) {
    if (value is DateTime) {
      final hora = value.hour.toString().padLeft(2, '0');
      final minutos = value.minute.toString().padLeft(2, '0');
      return '$hora:$minutos';
    }

    return null;
  }
}
