import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int qty;
  final double price;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.qty,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.qty;
      },
    );
    return total;
  }

  void addItem(String productId, String tittle, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            qty: existingCartItem.qty + 1,
            price: existingCartItem.price),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: tittle,
          qty: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }
}
