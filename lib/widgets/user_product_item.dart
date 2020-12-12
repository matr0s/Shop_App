import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageSrc;

  UserProductItem({this.title, this.description, this.imageSrc});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imageSrc)),
      title: Text(title),
      subtitle: Text(description),
      trailing: Container(
        width: 100.0,
        child: Row(children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
