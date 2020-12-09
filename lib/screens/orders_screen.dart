import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

//
// Screen where you can find orders you made before. Listview based on OrderItem Widget
//
class OrdersScreen extends StatelessWidget {
  // Screen id - special for named routes config
  static const routeId = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orders.orders[i]),
        itemCount: orders.orders.length,
      ),
    );
  }
}
