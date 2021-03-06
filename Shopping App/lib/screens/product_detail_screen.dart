import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  //const ProductDetailScreen({ Key? key }) : super(key: key);
  static const routName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
        ),
      ),
      body: Container(
        height: 300,
        width: double.infinity,
        child: Image.network(
          loadedProduct.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
