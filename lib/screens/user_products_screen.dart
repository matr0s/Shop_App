import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products_provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeId = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, int i) => Column(children: [
            UserProductItem(
              title: productsData.items[i].title,
              description: productsData.items[i].description,
              imageSrc: productsData.items[i].imageUrl,
            ),
            Divider(
              color: Colors.grey,
            ),
          ]),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
