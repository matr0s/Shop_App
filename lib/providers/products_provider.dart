import 'package:flutter/material.dart';

import 'product.dart';

//
// Provider for product list we have in our Shop Catalog and methods for this providers
//
class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

// Get products list copy. Secur direct and external access
  List<Product> get items {
    return [..._items];
  }

// Generate list of products with Fave flag.
  List<Product> get faveItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

// Search product by ID
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

// Not sure :) I am going to use this method in case we add New Product creation feature
  void addProduct() {
    // _items.add(value);
    notifyListeners();
  }
}
