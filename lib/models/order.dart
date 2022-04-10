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
  OrderStatus status;
  int weight;
  DateTime startTw;
  DateTime endTw;
  late Jalali estimationArrival;
  late Jalali estimationDepart;

  Order({
    required this.id,
    this.storage,
    this.store,
    required this.title,
    required this.status,
    required this.weight,
    required this.startTw,
    required this.endTw,
    required DateTime estimationArrival,
    required DateTime estimationDepart,
  }) {
    this.estimationArrival = Jalali.fromDateTime(estimationArrival);
    this.estimationDepart = Jalali.fromDateTime(estimationDepart);
  }

  void changeStatus(OrderStatus newStatus) {
    // TODO call api to change status
    status = newStatus;
    notifyListeners();
  }
}