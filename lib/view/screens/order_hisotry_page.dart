import 'package:amadyar/view/widgets/order_history_card.dart';
import 'package:flutter/material.dart';
import '../../dummy_data/dummy_orders.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

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
