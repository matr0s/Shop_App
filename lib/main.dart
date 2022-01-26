import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/orders_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/cart_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';

import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders()),
      ],
      child: MaterialApp(
        title: 'ElectroMag',
        theme: ThemeData(
          fontFamily: 'Lato',
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
              .copyWith(secondary: Colors.deepOrange),
        ),
        initialRoute: ProductsOverviewScreen.routeId,
        routes: {
          ProductsOverviewScreen.routeId: (context) => ProductsOverviewScreen(),
          ProductDetailsScreen.routeId: (context) => ProductDetailsScreen(),
          CartScreen.routeId: (context) => CartScreen(),
          OrdersScreen.routeId: (context) => OrdersScreen(),
          UserProductsScreen.routeId: (context) => UserProductsScreen(),
          EditProductScreen.routeId: (context) => EditProductScreen(),
        },
      ),
    );
  }
}
