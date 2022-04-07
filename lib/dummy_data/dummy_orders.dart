
import 'package:amadyar/models/order.dart';
import 'package:amadyar/models/storage.dart';
import 'package:amadyar/models/store.dart';
import 'package:flutter/cupertino.dart';

class Orders with ChangeNotifier {
 static List<Order> items = [
  Order(
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
       storeOwner: 'حسن آقا'
   ),
   title: 'title',
   status: OrderStatus.MISSED,
   weight: 12,
   startTw: DateTime.now(),
   endTw: DateTime.now(),
  ),
Order(
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
       storeOwner: 'حسن آقا'
   ),
   title: 'title',
   status: OrderStatus.COMPLETE,
   weight: 12,
   startTw: DateTime.now(),
   endTw: DateTime.now(),
  ),
Order(
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
       storeOwner: 'حسن آقا'
   ),
   title: 'title',
   status: OrderStatus.BACKLOG,
   weight: 12,
   startTw: DateTime.now(),
   endTw: DateTime.now(),
  ),
    Order(
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
       storeOwner: 'حسن آقا'
   ),
   title: 'title',
   status: OrderStatus.MISSED,
   weight: 12,
   startTw: DateTime.now(),
   endTw: DateTime.now(),
  ),
Order(
   storage: Storage(
       label: 'انیار',
       address: 'بلوار جمهوری انباله هوراااا',
       latitude: 22,
       longitude: 334,
   ),
   store: Store(
       name: 'سوپری',
       storeCode: '1234',
       address: 'بلوار جمهوری حسن آقا اینا a;dkjfl;ajdfk;ladjfk;dajf;kasjdfk;aldskhfgro;iwejhgndgh;egwjdkwirhejnfvkdjhgerjndvig',
       latitude: 12,
       longitude: 124,
       storeOwner: 'حسن آقا'
   ),
   title: 'title',
   status: OrderStatus.COMPLETE,
   weight: 12,
   startTw: DateTime.now(),
   endTw: DateTime.now(),
  ),
Order(
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
       storeOwner: 'حسن آقا'
   ),
   title: 'title',
   status: OrderStatus.BACKLOG,
   weight: 12,
   startTw: DateTime.now(),
   endTw: DateTime.now(),
  ),

 ];

 List<Order> get getItems{
   return [...items];
 }

 void UpdateOrder(){
   notifyListeners();
 }
}
