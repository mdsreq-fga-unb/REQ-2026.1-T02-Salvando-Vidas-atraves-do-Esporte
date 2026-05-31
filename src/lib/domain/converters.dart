import 'package:json_annotation/json_annotation.dart';

class DateConverter implements JsonConverter<DateTime, String> {
  const DateConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String().split('T').first;
  }
}

class TimeConverter implements JsonConverter<DateTime, String> {
  const TimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse('1970-01-01T$json');
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String().substring(11, 19);
  }
}
