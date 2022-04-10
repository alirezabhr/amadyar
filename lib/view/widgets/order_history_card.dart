import 'package:flutter/material.dart';
import '../../models/order.dart';

class OrderHistoryCard extends StatelessWidget {
  final Map<OrderStatus, Map<String, Object>> map = const {
    OrderStatus.DELIVERED: {
      'color': Color.fromARGB(255, 153, 241, 156),
      'text': 'تحویل داده شده'
    },
    OrderStatus.ASSIGNED: {
      'color': Color.fromARGB(255, 247, 238, 125),
      'text': 'شروع نشده'
    },
    OrderStatus.IN_PROGRESS: {
      'color': Color.fromARGB(255, 133, 235, 253),
      'text': 'در حال انجام'
    },
    OrderStatus.ARRIVED: {
      'color': Color.fromARGB(255, 253, 161, 161),
      'text': 'در حال تخلیه'
    },
  };

  final Order order;

  const OrderHistoryCard(this.order, {Key? key}) : super(key: key);

  Widget? get originAddressText {
    if (order.storage != null) {
      return Text("مبدا: ${order.storage?.address}");
    }
    return null;
  }

  Widget? get destinationAddressText {
    if (order.store != null) {
      return Text("مقصد: ${order.store!.address}");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      margin:  const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        color: map[order.status]!["color"] as Color,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  originAddressText,
                  destinationAddressText,
                  Text("مرسوله: ${order.title}"),
                  Text("وزن: ${order.weight}"),
                  Text(
                    "${order.startTw}",
                    textDirection: TextDirection.rtl,
                  ),
                  Text(
                    "${order.endTw}",
                    textDirection: TextDirection.rtl,
                  ),
                ]
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: e,
                        ),
                      ),
                    )
                    .toList(),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${map[order.status]!["text"]}",
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
