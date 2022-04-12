import 'package:amadyar/view/widgets/order_history_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/history_orders_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryOrdersProvider ordersProvider =
    Provider.of<HistoryOrdersProvider>(context);

    return RefreshIndicator(
      onRefresh: ordersProvider.updateOrders,
      child: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (BuildContext context, int index) {
            return OrderHistoryCard(ordersProvider.orders[index]);
          },
        ),
    );
  }
}
