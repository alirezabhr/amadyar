import 'package:flutter/material.dart';

import '../widgets/cartable_order_card.dart';

import '../../dummy_data/dummy_orders.dart';
import '../../models/order.dart';

class CartableScreen extends StatefulWidget {
  const CartableScreen({Key? key}) : super(key: key);

  @override
  State<CartableScreen> createState() => _CartableScreenState();
}

class _CartableScreenState extends State<CartableScreen> {
  final List<Order> _orders = [
    DummyOrders.items.first,
    DummyOrders.items.last,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: _orders
            .map(
              (order) => CartableOrderCard(
                isNextOrder: _orders.indexOf(order) == 0,
                order: order,
              ),
            )
            .toList(),
      ),
    );
  }
}
