import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

//
// Cart item => One product with all the data about
//
class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int qty;
  final String title;

  CartItem({this.id, this.productId, this.price, this.qty, this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure???',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            content: Text('Please, be careful!!'),
            actions: [
              FlatButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('OKi'),
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('${price}')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$ ${(price * qty)}'),
            trailing: Text('$qty x'),
          ),
        ),
      ),
    );
  }
}
