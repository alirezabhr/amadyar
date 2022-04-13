import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:amadyar/models/storage.dart';
import 'package:amadyar/models/store.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../controllers/server_data.dart';

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
  double? weight;
  late Jalali startTw;
  late Jalali endTw;
  late Jalali estimationArrival;
  late Jalali estimationDepart;


  Order({
    required this.id,
    this.storage,
    this.store,
    required this.title,
    required String statusText,
    required this.weight,
    required double startTw,
    required double endTw,
    required double estimationArrival,
    required double estimationDepart,
  }) {
    status = _convertStrToStatus(statusText);
    this.startTw = jalaliFromUnixDouble(startTw);
    this.endTw = jalaliFromUnixDouble(endTw);
    this.estimationArrival = jalaliFromUnixDouble(estimationArrival);
    this.estimationDepart = jalaliFromUnixDouble(estimationDepart);
  }

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

  Jalali jalaliFromUnixDouble(double unixDateTime) {
    return Jalali.fromDateTime(DateTime.fromMillisecondsSinceEpoch(unixDateTime.toInt()));
  }

  String _statusToStr(OrderStatus newStatus) {
    switch (newStatus) {
      case OrderStatus.ASSIGNED:
        return 'AS';
      case OrderStatus.ARRIVED:
        return 'AR';
      case OrderStatus.IN_PROGRESS:
        return 'IP';
      case OrderStatus.DELIVERED:
        return 'DL';
    }
  }

  Future<void> changeStatus(OrderStatus newStatus) async {
    Dio dio = await ServerData().getDio();
    Map data = {'status': _statusToStr(newStatus)};
    var response = await dio.post('/haul/order/change_status/$id/', data: data);
    print(response.data);

    status = newStatus;
    notifyListeners();
  }
}
