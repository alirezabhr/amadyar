import 'package:amadyar/controllers/server_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/order.dart';

class HistoryOrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> updateOrders() async {
    Dio dio = await ServerData().getDio();
    var response = await dio.get('haul/order/');

    _orders = [];
    response.data.forEach((data) {
      Order order = Order(
        id: data['id'],
        title: data['title'],
        statusText: data['status'],
        weight: data['weight'],
        startTw: data['start_tw'],
        endTw: data['end_tw'],
        estimationArrival: data['estimation_arrival'],
        estimationDepart: data['estimation_depart'],
      );
      _orders.add(order);
    });

    notifyListeners();
  }
}
