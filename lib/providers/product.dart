import 'package:flutter/foundation.dart';

//====================>
// Order Item object - Including List of products we addded to the cart => CartItem class
//====================>
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

// Flag which shows us if product marked as Fave
  void toggleFaveStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  //// END OF THE CLASS =================>
}
