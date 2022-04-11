import 'package:flutter/foundation.dart';

import 'package:amadyar/models/storage.dart';
import 'package:amadyar/models/store.dart';
import 'package:shamsi_date/shamsi_date.dart';

enum OrderStatus {
  ASSIGNED,
  IN_PROGRESS,
  ARRIVED,
  DELIVERED,
}

class Order with ChangeNotifier {
  int id;
  Storage? storage;
  Store? store;
  String title;
  late OrderStatus status;
  int weight;
  DateTime startTw;
  DateTime endTw;
  late Jalali estimationArrival;
  late Jalali estimationDepart;

  OrderStatus _convertStrToStatus(String strStatus) {
    OrderStatus s = OrderStatus.ASSIGNED;
    switch (strStatus) {
      case 'AS':
        s = OrderStatus.ASSIGNED;
        break;
      case 'IP':
        s = OrderStatus.IN_PROGRESS;
        break;
      case 'AR':
        s = OrderStatus.ARRIVED;
        break;
      case 'DL':
        s = OrderStatus.DELIVERED;
        break;
    }
    return s;
  }

  Order({
    required this.id,
    this.storage,
    this.store,
    required this.title,
    required String statusText,
    required this.weight,
    required this.startTw,
    required this.endTw,
    required DateTime estimationArrival,
    required DateTime estimationDepart,
  }) {
    status = _convertStrToStatus(statusText);
    this.estimationArrival = Jalali.fromDateTime(estimationArrival);
    this.estimationDepart = Jalali.fromDateTime(estimationDepart);
  }

  void changeStatus(OrderStatus newStatus) {
    // TODO call api to change status
    status = newStatus;
    notifyListeners();
  }
}
