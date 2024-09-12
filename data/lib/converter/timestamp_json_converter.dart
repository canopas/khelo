import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TimeStampJsonConverter extends JsonConverter<DateTime, Object> {
  const TimeStampJsonConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) {
      return json.toDate();
    } else {
      final jsonMap = Map<String, dynamic>.from(json as Map);
      final seconds = jsonMap['_seconds'] as int;
      final nanoseconds = jsonMap['_nanoseconds'] as int;
      return Timestamp(seconds, nanoseconds).toDate();
    }
  }

  @override
  Object toJson(DateTime object) => Timestamp.fromDate(object);
}
