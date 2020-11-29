import 'package:flutter/material.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeId = '/product-details';
  @override
  Widget build(BuildContext context) {
//
    // Getting arguments from NamedRoute
    final String productId =
        ModalRoute.of(context).settings.arguments as String;
//
    // Here we are going to get all the data for my product based on ID
    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);
// ======================================================
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
    );
  }
}
