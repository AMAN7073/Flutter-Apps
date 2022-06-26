import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/auth.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({ Key? key }) : super(key: key);
  // final String id;
  // final String title;
  // final String imageurl;

  // ProductItem(this.id, this.title, this.imageurl);

  @override
  Widget build(BuildContext context) {
    final product_Item = Provider.of<Product>(context);
    final cartItem = Provider.of<Cart>(context);
    final String? token = Provider.of<Auth>(context, listen: false).token;
    final String? userId = Provider.of<Auth>(context, listen: false).userId;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routName,
                arguments: product_Item.id);
          },
          child: Image.network(
            product_Item.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product_Item.title,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
              onPressed: () => product_Item.toggleFavourite(token, userId),
              icon: Icon(
                product_Item.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor),
          trailing: IconButton(
            onPressed: () {
              cartItem.additem(
                  product_Item.id, product_Item.price, product_Item.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item Added to Cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cartItem.removeSingleItem(product_Item.id);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_cart,
            ),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
