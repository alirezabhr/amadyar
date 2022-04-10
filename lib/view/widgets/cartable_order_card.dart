import 'package:amadyar/models/order.dart';
import 'package:flutter/material.dart';

class CartableOrderCard extends StatelessWidget {
  final bool isNextOrder;
  final Order order;

  const CartableOrderCard(
      {Key? key, required this.isNextOrder, required this.order})
      : super(key: key);

  String get buttonText {
    if (isNextOrder) {
      if (order.status == OrderStatus.IN_PROGRESS) {
        // not arrived
        return 'به مقصد رسیدم';
      } else if (order.status == OrderStatus.COMPLETE) {
        // arrived but not delivered
        return 'تحویل دادم';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  void arrived() {}

  void delivered() {}

  void Function()? get buttonEvent {
    if (isNextOrder) {
      if (order.status == OrderStatus.IN_PROGRESS) {
        // not arrived
        return arrived;
      } else if (order.status == OrderStatus.COMPLETE) {
        // arrived but not delivered
        return delivered;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isNextOrder
          ? Theme.of(context).colorScheme.secondary
          : Colors.black26,
      child: Column(
        children: [
          Text(order.title),
          Text('زمان پیشنهادی: ${order.estimationArrival.toString()}'),
          isNextOrder
              ? ElevatedButton(onPressed: buttonEvent, child: Text(buttonText))
              : Container(),
        ],
      ),
    );
  }
}
