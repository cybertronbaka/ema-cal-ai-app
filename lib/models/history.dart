import 'package:ema_cal_ai/enums/enums.dart';

class History {
  const History({
    this.id,
    required this.type,
    required this.value,
    required this.createdAt,
  });

  final int? id;
  final DateTime createdAt;
  final HistoryType type;
  final double value;
}
