import 'package:flutter/material.dart';

import '../providers/cart.dart';

//====================>
// Order Item object - Including List of products we addded to the cart => CartItem class
//====================>
class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.datetime,
  });
}

//====================>
// Cart Item object / Provider
//====================>
class Orders with ChangeNotifier {
// Empty list of our future orders
  List<OrderItem> _orders = [];

// Getter which retur us a copy of the order list. Secured direct and external accees to the original list
  List<OrderItem> get orders {
    return [..._orders];
  }

// Method which allows to add new orders to the initial list _orders
  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartProducts,
          datetime: DateTime.now(),
        ));
    notifyListeners();
  }

  //// END OF THE CLASS =================>
}
