import 'package:amadyar/controllers/server_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/order.dart';

class CartableOrdersProvider with ChangeNotifier {
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
  ];

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
    //api call to get orders
    print('hey i was called');
    Dio dio = await ServerData().getDio();
    var url = '${ServerData.serverBaseAPI}/haul/order/';
    try{
      var response = await dio.get(url);
      //assign response to orders and handel errors  
    } catch (e){
      // do nothing? or get orders from cache
    }
    notifyListeners();
  } 

}