import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderHistoryCard extends StatelessWidget {

  final Map<OrderStatus, Map<String, Object>> map = const {
    OrderStatus.COMPLETE: {
      'color': Color.fromARGB(255, 149, 211, 151),
      'text': 'CP'
    },
    OrderStatus.BACKLOG: {
      'color': Color.fromARGB(255, 221, 214, 121),
      'text': 'BL'
    },
    OrderStatus.IN_PROGRESS: {
      'color': Color.fromARGB(255, 120, 204, 219),
      'text': 'IP'
    },
    OrderStatus.MISSED: {
      'color': Color.fromARGB(255, 190, 150, 223),
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
          color: map[order.status]!['color'] as Color,
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
                    Text("${order.startTw}"),
                    Text("${order.endTw}"),
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
                  child: Text("${order.status}"),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
