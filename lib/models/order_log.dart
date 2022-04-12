enum LogAction {
  STARTED,
  ON_THE_WAY,
  ENDED,
}

class OrderLog {
  final int orderId;
  final double latitude;
  final double longitude;
  final DateTime dateTime;
  final LogAction action;

  OrderLog({
    required this.orderId,
    required this.latitude,
    required this.longitude,
    required this.dateTime,
    required this.action,
  });

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
      'related_order': orderId,
      'longitude': longitude,
      'latitude': latitude,
      'current_datetime': dateTime,
      'action': _actionStr,
    };
  }
}
