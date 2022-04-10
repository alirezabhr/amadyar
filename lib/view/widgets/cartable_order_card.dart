import 'package:amadyar/controllers/cartable_orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order.dart';

class CartableOrderCard extends StatelessWidget {
  final bool isNextOrder;
  final Order order;

  const CartableOrderCard(
      {Key? key, required this.isNextOrder, required this.order})
      : super(key: key);

  String get buttonText {
    if (isNextOrder) {
      if (order.status == OrderStatus.ASSIGNED) {
        // not arrived
        return 'شروع سفر بعد';
      } else if (order.status == OrderStatus.IN_PROGRESS) {
        // not arrived
        return 'به مقصد رسیدم';
      } else if (order.status == OrderStatus.ARRIVED) {
        // arrived but not delivered
        return 'تحویل دادم';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  String get jalaliFormattedDate {
    return '${order.estimationArrival.formatter.wN} - ${order.estimationArrival.formatter.d} ${order.estimationArrival.formatter.mN}';
  }

  String get formattedTime {
    return 'ساعت ${order.estimationArrival.hour}:${order.estimationArrival.minute}';
  }

  @override
  Widget build(BuildContext context) {
    final CartableOrdersProvider ordersController =
        Provider.of<CartableOrdersProvider>(context);
    final Size deviceSize = MediaQuery.of(context).size;

    return Container(
      width: (deviceSize.width * 3) / 4,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        color: isNextOrder ? const Color(0xFFC6E2F5) : const Color(0xFFE2E2E2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(order.title),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'زمان پیشنهادی تحویل: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(jalaliFormattedDate),
                    Text(formattedTime)
                  ],
                ),
              ),
              isNextOrder
                  ? ElevatedButton(
                      onPressed: () {
                        if (isNextOrder) {
                          if (order.status == OrderStatus.ASSIGNED) {
                            // started
                            ordersController.orderStarted();
                          } else if (order.status == OrderStatus.IN_PROGRESS) {
                            // arrived
                            ordersController.orderArrived();
                          } else if (order.status == OrderStatus.ARRIVED) {
                            // delivered
                            ordersController.orderDelivered();
                          }
                        }
                      },
                      child: Text(
                        buttonText,
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
