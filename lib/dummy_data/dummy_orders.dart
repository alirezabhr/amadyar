import 'package:amadyar/models/order.dart';
import 'package:amadyar/models/storage.dart';
import 'package:amadyar/models/store.dart';
import 'package:flutter/cupertino.dart';

class DummyOrders with ChangeNotifier {
  static List<Order> items = [
    Order(
      id: 3,
      title: '۴تا دوغ آبعلی',
      statusText: 'IP',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
    Order(
      id: 5,
      storage: Storage(
        label: 'انیار',
        address: 'بلوار جمهوری انباله هوراااا',
        latitude: 22,
        longitude: 334,
      ),
      store: Store(
          name: 'سوپری',
          storeCode: '1234',
          address: 'بلوار جمهوری حسن آقا اینا',
          latitude: 12,
          longitude: 124,
          storeOwner: 'حسن آقا'),
      title: '۶تا ماست موسیر رامک',
      statusText: 'AS',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
    Order(
      id: 6,
      storage: Storage(
        label: 'انیار',
        address: 'بلوار جمهوری انباله هوراااا',
        latitude: 22,
        longitude: 334,
      ),
      store: Store(
          name: 'سوپری',
          storeCode: '1234',
          address: 'بلوار جمهوری حسن آقا اینا',
          latitude: 12,
          longitude: 124,
          storeOwner: 'حسن آقا'),
      title: 'title',
      statusText: 'AS',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
    Order(
      id: 7,
      storage: Storage(
        label: 'انیار',
        address: 'بلوار جمهوری انباله هوراااا',
        latitude: 22,
        longitude: 334,
      ),
      store: Store(
          name: 'سوپری',
          storeCode: '1234',
          address: 'بلوار جمهوری حسن آقا اینا',
          latitude: 12,
          longitude: 124,
          storeOwner: 'حسن آقا'),
      title: 'title',
  statusText: 'AS',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
    Order(
      id: 8,
      storage: Storage(
        label: 'انیار',
        address: 'بلوار جمهوری انباله هوراااا',
        latitude: 22,
        longitude: 334,
      ),
      store: Store(
          name: 'سوپری',
          storeCode: '1234',
          address:
              'بلوار جمهوری حسن آقا اینا a;dkjfl;ajdfk;ladjfk;dajf;kasjdfk;aldskhfgro;iwejhgndgh;egwjdkwirhejnfvkdjhgerjndvig',
          latitude: 12,
          longitude: 124,
          storeOwner: 'حسن آقا'),
      title: 'title',
  statusText: 'AS',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
    Order(
      id: 12,
      storage: Storage(
        label: 'انیار',
        address: 'بلوار جمهوری انباله هوراااا',
        latitude: 22,
        longitude: 334,
      ),
      store: Store(
          name: 'سوپری',
          storeCode: '1234',
          address: 'بلوار جمهوری حسن آقا اینا',
          latitude: 12,
          longitude: 124,
          storeOwner: 'حسن آقا'),
      title: '۶تا ماست موسیر رامک',
      statusText: 'AS',
      weight: 12,
      startTw: DateTime.now(),
      endTw: DateTime.now(),
      estimationArrival: DateTime.now().add(Duration(hours: 2)),
      estimationDepart: DateTime.now().add(Duration(hours: 3)),
    ),
  ];

  List<Order> get getItems {
    return [...items];
  }

  void UpdateOrder() {
    notifyListeners();
  }
}
