import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';
import '../widgets/order_items.dart';
import '../providers/order.dart';

class OrdersScreen extends StatefulWidget {
  //const O({ Key? key }) : super(key: key);

  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;
  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrderFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (dataSnapshot.error != null) {
            return const Center(
              child: Text('An Error Occured'),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, orderData, child) => ListView.builder(
                itemBuilder: ((context, index) => Order_Items(
                      orderData.orders[index],
                    )),
                itemCount: orderData.orders.length,
              ),
            );
          }
        },
      ),
    );
  }
}
