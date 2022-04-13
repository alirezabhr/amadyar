import 'package:intl/intl.dart';

enum LogAction {
  STARTED,
  ON_THE_WAY,
  ENDED,
}

class OrderLog {
  final int orderId;
  final double latitude;
  final double longitude;
  late final DateTime dateTime;
  final LogAction action;

  OrderLog({
    required this.orderId,
    required this.latitude,
    required this.longitude,
    required this.action,
  }) {
    dateTime = DateTime.now();
  }

  String get _actionStr {
    if (action == LogAction.STARTED) {
      return 'ST';
    } else if (action == LogAction.ON_THE_WAY) {
      return 'OW';
    } else {
      return 'ED';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'current_datetime': DateFormat('yyyy-MM-ddTH:m:s').format(dateTime),
      'action': _actionStr,
    };
  }
}
