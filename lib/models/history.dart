import 'package:clock/clock.dart';
import 'package:ema_cal_ai/database/database.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:ema_cal_ai/extensions/db_extension.dart';

class History {
  History({
    this.id,
    required this.type,
    required this.value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? clock.now(),
       updatedAt = updatedAt ?? clock.now();

  factory History.fromDB(DbHistory history) {
    return History(
      id: history.id.toInt(),
      type: history.type,
      value: history.value,
      updatedAt: history.updatedAt,
      createdAt: history.createdAt,
    );
  }

  final int? id;
  final DateTime updatedAt;
  final DateTime createdAt;
  final HistoryType type;
  final double value;

  DbHistory toDB() {
    return DbHistory(
      id: id?.toBigInt() ?? -1.toBigInt(),
      type: type,
      value: value,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}
