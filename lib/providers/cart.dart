import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

//====================>
// Cart Item object
//====================>
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

//====================>
// Cart object / Provider including all the necessary logic related to the Shopping Cart
//====================>
class Cart with ChangeNotifier {
// Our future list with products we added to the Cart
  Map<String, CartItem> _items = {};

// Getter which helps us to get a copy of the Cart items. Protect original list from external access
  Map<String, CartItem> get items {
    return {..._items};
  }

// Get Qty of products in our Shopping Cart
  int get itemCount {
    return _items == null ? 0 : _items.length;
  }

// Get Total amount for teh products we have in our Shopping Cart
  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, cartItem) {
        total += cartItem.price * cartItem.qty;
      },
    );
    return total;
  }

// Method which alows us to add items to teh Shopping Cart
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

// Method which allows us to remove product from the Shopping Cart list
  void removeItem(String itemId) {
    _items.remove(itemId);
    notifyListeners();
  }

// Shopping Cart Products list cleaning
  void clearCart() {
    _items = {};
    notifyListeners();
  }

  // END OF THE CLASS =============>
}
