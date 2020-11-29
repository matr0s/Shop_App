import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeId = '/product-details';

  @override
  Widget build(BuildContext context) {
    final String screenArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(screenArgs),
      ),
    );
  }
}
