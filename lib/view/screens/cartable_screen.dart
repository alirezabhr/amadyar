import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/cartable_orders_provider.dart';
import '../widgets/cartable_order_card.dart';

class CartableScreen extends StatefulWidget {
  const CartableScreen({Key? key}) : super(key: key);

  @override
  State<CartableScreen> createState() => _CartableScreenState();
}

class _CartableScreenState extends State<CartableScreen> {
  @override
  Widget build(BuildContext context) {
    final CartableOrdersProvider ordersCtrl =
        Provider.of<CartableOrdersProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: RefreshIndicator(
        onRefresh: ordersCtrl.updateOrders,
        child: ordersCtrl.orders.isEmpty
            ? const Center(
                child: Text(
                  "سفارشی موجود نیست",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
                itemCount: ordersCtrl.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartableOrderCard(
                      isNextOrder: index == 0 ? true : false,
                      order: ordersCtrl.orders[index]);
                },
              ),
      ),
    );
  }
}
