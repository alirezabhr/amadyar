import 'package:amadyar/controllers/server_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/order.dart';

class CartableOrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void orderStarted() {
    final Order order = _orders.first;
    order.changeStatus(OrderStatus.IN_PROGRESS);
    notifyListeners();
  }

  void orderArrived() {
    final Order order = _orders.first;
    order.changeStatus(OrderStatus.ARRIVED);
    notifyListeners();
  }

  void orderDelivered() {
    final Order order = _orders.first;
    order.changeStatus(OrderStatus.DELIVERED);
    _orders.removeAt(0);
    notifyListeners();
  }

  Future<void> updateOrders() async {
    Dio dio = await ServerData().getDio();
    var response = await dio.get('/haul/order/uncompleted/');

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