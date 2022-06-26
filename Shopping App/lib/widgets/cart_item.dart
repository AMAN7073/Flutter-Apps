import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class Cart_Items extends StatelessWidget {
  //const CartItem({ Key? key }) : super(key: key);
  final String id;
  final String productid;
  final int quantity;
  final double price;
  final String title;

  Cart_Items(this.id, this.productid, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.blueAccent,
        child: const Icon(
          Icons.delete,
          color: Colors.amberAccent,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        padding: const EdgeInsets.all(8),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (directoin) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are You Sure?'),
            content: const Text(
              'Do you want to remove the Item from the Cart?',
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("YES"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('NO'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productid);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
