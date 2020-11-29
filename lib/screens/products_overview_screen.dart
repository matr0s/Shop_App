import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';


class ProductsOverviewScreen extends StatelessWidget {
  static const routeId = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ElectroMag'),
      ),
      body: ProductsGrid(),
    );
  }
}


