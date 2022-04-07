import 'package:amadyar/view/widgets/order_history_card.dart';
import 'package:flutter/material.dart';
import '../../dummy_data/dummy_orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Orders.items.length,
      itemBuilder: (BuildContext context, int index) {
          return OrderHistoryCard(Orders.items[index]);
        },
      );
  }
}
