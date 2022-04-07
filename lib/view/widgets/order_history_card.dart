import 'package:flutter/material.dart';
import '../../models/order.dart';

class OrderHistoryCard extends StatelessWidget {

  final Map<OrderStatus, Map<String, Object>> map = const {
    OrderStatus.COMPLETE: {
      'color': Color.fromARGB(255, 153, 241, 156),
      'text': 'CP'
    },
    OrderStatus.BACKLOG: {
      'color': Color.fromARGB(255, 247, 238, 125),
      'text': 'BL'
    },
    OrderStatus.IN_PROGRESS: {
      'color': Color.fromARGB(255, 133, 235, 253),
      'text': 'IP'
    },
    OrderStatus.MISSED: {
      'color': Color.fromARGB(255, 253, 161, 161),
      'text': 'MI'
    },
  };

  final Order order;
  const OrderHistoryCard(this.order, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 4, bottom: 0, left: 4, right: 4),
        child: Card(       
          color: map[order.status]!["color"] as Color,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("مبدا: ${order.storage.address}"),
                    Text("مقصد: ${order.store.address}"),
                    Text("مرسوله: ${order.title}"),
                    Text("وزن: ${order.weight}"),
                    //TODO: make dates shamsi
                    Text("${order.startTw}", textDirection: TextDirection.rtl,),
                    Text("${order.endTw}", textDirection: TextDirection.rtl,),
                  ].map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(4),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: e,
                    ) ,
                  ),
                )
                .toList(),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${map[order.status]!["text"]}", style: TextStyle(fontSize: 10),),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
