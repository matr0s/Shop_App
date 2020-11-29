import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ElectroMag',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      //home: ProductsOverviewScreen(),
      initialRoute: ProductsOverviewScreen.routeId,
      routes: {
        ProductsOverviewScreen.routeId : (context) => ProductsOverviewScreen(),
        ProductDetailsScreen.routeId : (context) => ProductDetailsScreen(),
      },
    );
  }
}
