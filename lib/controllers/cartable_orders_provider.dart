import 'package:amadyar/controllers/map_provider.dart';
import 'package:amadyar/controllers/server_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';

class CartableOrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  bool _isSubmitting = false;

  bool get isSubmitting => _isSubmitting;

  void changeIsSubmitting(bool newValue) {
    _isSubmitting = newValue;
    notifyListeners();
  }

  void orderStarted(BuildContext ctx) async {
    changeIsSubmitting(true);
    final Order order = _orders.first;
    await order.changeStatus(OrderStatus.IN_PROGRESS);
    Provider.of<MapProvider>(ctx, listen: false).runTracker(order.id);
    changeIsSubmitting(false);
    notifyListeners();
  }

  void orderArrived(BuildContext ctx) async {
    changeIsSubmitting(true);
    final Order order = _orders.first;
    await order.changeStatus(OrderStatus.ARRIVED);
    Provider.of<MapProvider>(ctx, listen: false).stopTracker(order.id);
    changeIsSubmitting(false);
    notifyListeners();
  }

  void orderDelivered(BuildContext ctx) async {
    changeIsSubmitting(true);
    final Order order = _orders.first;
    await order.changeStatus(OrderStatus.DELIVERED);
    changeIsSubmitting(false);
    _orders.removeAt(0);
    Provider.of<MapProvider>(ctx, listen: false).getDriverNextOrder();
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
