import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeId = '/product-details';

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
// Here wi are going to get all the data for my product based on ID
    return Scaffold(
      appBar: AppBar(
        title: Text(productId),
      ),
    );
  }
}
