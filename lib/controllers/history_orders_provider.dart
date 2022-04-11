
import 'package:flutter/foundation.dart';

import '../models/order.dart';

class HistoryOrdersProvider with ChangeNotifier{
  List<Order> _orders = [
    Order(
      id: 1,
      title: '۴تا دوغ آبعلی',
      statusText: 'AS',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
    Order(
      id: 12,
      title: '۶تا ماست موسیر رامک',
      statusText: 'DL',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 6)),
      estimationDepart: DateTime.now().add(Duration(hours: 6, minutes: 30)),
    ),
  ];

  List<Order> get orders => _orders;

  Future<void> updateOrders() async {
    //api call to get orders
    notifyListeners();
  } 

}