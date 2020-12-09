import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

//
// Product interface
//
class ProductDetailsScreen extends StatelessWidget {
  // Screen id - special for named routes config
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '\$ ${loadedProduct.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('${loadedProduct.description}'),
          ],
        ),
      ),
    );
  }
}
