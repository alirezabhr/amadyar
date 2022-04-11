
import 'package:amadyar/controllers/server_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/order.dart';

class HistoryOrdersProvider with ChangeNotifier{
  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  Future<void> updateOrders() async {
    //api call to get orders
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