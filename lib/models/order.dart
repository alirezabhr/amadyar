
import 'package:amadyar/models/storage.dart';
import 'package:amadyar/models/store.dart';

enum OrderStatus {
  COMPLETE,
  IN_PROGRESS,
  BACKLOG,
  MISSED,
}

class Order{

  Storage storage;
  Store store;
  String title;
  OrderStatus status;
  int weight;
  DateTime startTw;
  DateTime endTw;

  Order({
    required this.storage,
    required this.store,
    required this.title,
    required this.status,
    required this.weight,
    required this.startTw,
    required this.endTw,
  });
}