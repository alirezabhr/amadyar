import 'package:amadyar/controllers/history_orders_provider.dart';
import 'package:amadyar/view/widgets/order_history_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    Provider.of<HistoryOrdersProvider>(context, listen: false).updateOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final HistoryOrdersProvider ordersCtrl =
        Provider.of<HistoryOrdersProvider>(context);

    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: ordersCtrl.updateOrders,
          child: ListView.builder(
            itemCount: ordersCtrl.orders.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderHistoryCard(ordersCtrl.orders[index]);
            },
          ),
        )
      );
  }
}
