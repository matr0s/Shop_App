import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

//
// Screen to review cart items and data
//
class CartScreen extends StatelessWidget {
  // Screen id - special for named routes config
  static const routeId = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline6.fontSize,
                          color: Theme.of(context).textTheme.headline6.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      /// Provider which add orders to the Orders List
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);

                      /// Cleaning cart after order complete
                      cart.clearCart();
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: Text('ORDER NOW'),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (BuildContext context, int i) => CartItem(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                title: cart.items.values.toList()[i].title,
                qty: cart.items.values.toList()[i].qty,
                price: cart.items.values.toList()[i].price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
